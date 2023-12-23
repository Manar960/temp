import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../config.dart';
import '../../Login/login_screen.dart';
import '../../components/already_have_an_account_acheck.dart';
import 'package:http/http.dart' as http;
import '../../components/background.dart';
import '../../constantslog.dart';
import '../../responsive.dart';
import '../sighnup_company.dart';
import 'sign_up_top_image.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: MobileSignupScreen(),
          desktop: Row(
            children: [
              Expanded(
                child: SignUpScreenTopImage(),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 450,
                      child: SignUpForm(),
                    ),
                    SizedBox(height: defaultPadding / 2),
                    // SocalSignUp()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MobileSignupScreen extends StatelessWidget {
  const MobileSignupScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        LayoutBuilder(
          builder: (context, constraints) {
            double thresholdWidth = 600;
            if (constraints.maxWidth > thresholdWidth) {
              return const SignUpScreenTopImage();
            } else {
              return Container();
            }
          },
        ),
        const Row(
          children: [
            Spacer(),
            Expanded(
              flex: 8,
              child: SignUpForm(),
            ),
            Spacer(),
          ],
        ),
        // const SocalSignUp()
      ],
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  static const List<String> cities = [
    "نابلس",
    "القدس",
    " جنين",
    " طولكرم",
    "قلقيلية",
    "أريحا"
  ];

  String? selectedCity;
  bool _isNotValidateE = false;
  bool _isNotValidateFN = false;
  bool _isNotValidateLN = false;
  bool _isNotValidateUN = false;
  bool _isNotValidateP = false;
  bool isPasswordVisible = false;
  bool isLoading = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passController = TextEditingController();

  void registUser() async {
    if (emailController.text.isNotEmpty &&
        passController.text.isNotEmpty &&
        firstnameController.text.isNotEmpty &&
        lastnameController.text.isNotEmpty &&
        usernameController.text.isNotEmpty &&
        selectedCity != null) {
      setState(() {
        isLoading = true;
      });
      var regBody = {
        "userFirstName": firstnameController.text,
        "userLastName": lastnameController.text,
        "email": emailController.text,
        "UserName": usernameController.text,
        "password": passController.text,
        "city": selectedCity,
        "isAdminExpert": false,
      };

      var response = await http.post(Uri.parse(registration),
          headers: {
            "Access-Control-Allow-Origin": "*",
            'Content-Type': 'application/json',
            'Accept': '*/*'
          },
          body: jsonEncode(regBody));
      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const LoginScreen();
            },
          ),
        );
      }
      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        if (emailController.text.isEmpty) {
          _isNotValidateE = true;
        } else {
          _isNotValidateE = false;
        }
      });
      setState(() {
        if (passController.text.isEmpty) {
          _isNotValidateP = true;
        } else {
          _isNotValidateP = false;
        }
      });
      setState(() {
        if (usernameController.text.isEmpty) {
          _isNotValidateUN = true;
        } else {
          _isNotValidateUN = false;
        }
      });

      setState(() {
        if (firstnameController.text.isEmpty) {
          _isNotValidateFN = true;
        } else {
          _isNotValidateFN = false;
        }
      });
      setState(() {
        if (lastnameController.text.isEmpty) {
          _isNotValidateLN = true;
        } else {
          _isNotValidateLN = false;
        }
      });

      if (selectedCity == null) {
        setState(() {
          _isNotValidateCity = true;
        });
      } else {
        setState(() {
          _isNotValidateCity = false;
        });
      }
    }
  }

  bool _isNotValidateCity = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Form(
          child: Column(
            children: [
              Directionality(
                textDirection: TextDirection.rtl,
                child: Text(
                  "إنشاء حساب ".toUpperCase(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: defaultPadding),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        controller: lastnameController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        cursorColor: kPrimaryColor,
                        onSaved: (email) {},
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        decoration: InputDecoration(
                          hintText: "الاسم العائلة",
                          filled: true,
                          errorStyle: const TextStyle(color: Colors.red),
                          errorText:
                              _isNotValidateLN ? "أدخل اسم العائلة " : null,
                          fillColor: const Color(0xffeef8f9),
                          iconColor: kPrimaryColor,
                          prefixIconColor: kPrimaryColor,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding,
                            vertical: defaultPadding,
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: const Padding(
                            padding: EdgeInsets.all(defaultPadding),
                            child: Icon(Icons.person),
                          ),
                          hintStyle: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    flex: 1,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        controller: firstnameController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        cursorColor: kPrimaryColor,
                        onSaved: (email) {},
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        decoration: InputDecoration(
                            hintText: "اسم الاول",
                            filled: true,
                            errorStyle: const TextStyle(color: Colors.red),
                            errorText: _isNotValidateFN ? "أدخل اسمك " : null,
                            fillColor: const Color(0xffeef8f9),
                            iconColor: kPrimaryColor,
                            prefixIconColor: kPrimaryColor,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: defaultPadding,
                              vertical: defaultPadding,
                            ),
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              borderSide: BorderSide.none,
                            ),
                            prefixIcon: const Padding(
                              padding: EdgeInsets.all(defaultPadding),
                              child: Icon(Icons.person),
                            ),
                            hintStyle: const TextStyle(color: Colors.grey)),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: defaultPadding),
              Directionality(
                textDirection: TextDirection.rtl,
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  cursorColor: kPrimaryColor,
                  onSaved: (email) {},
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                  decoration: InputDecoration(
                    hintText: "البريد الإلكتروني",
                    filled: true,
                    errorStyle: const TextStyle(color: Colors.red),
                    errorText:
                        _isNotValidateE ? "أدخل البريد الالكتروني " : null,
                    fillColor: const Color(0xffeef8f9),
                    iconColor: kPrimaryColor,
                    prefixIconColor: kPrimaryColor,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding,
                      vertical: defaultPadding,
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Icon(Icons.email),
                    ),
                    hintStyle: const TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: TextFormField(
                  controller: usernameController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  cursorColor: kPrimaryColor,
                  onSaved: (email) {},
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                  decoration: InputDecoration(
                    hintText: "اسم المستخدم",
                    filled: true,
                    errorStyle: const TextStyle(color: Colors.red),
                    errorText: _isNotValidateUN ? "أدخل اسم المستخدم " : null,
                    fillColor: const Color(0xffeef8f9),
                    iconColor: kPrimaryColor,
                    prefixIconColor: kPrimaryColor,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding,
                      vertical: defaultPadding,
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Icon(Icons.person),
                    ),
                    hintStyle: const TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: TextFormField(
                  controller: passController,
                  obscureText: !isPasswordVisible,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  cursorColor: kPrimaryColor,
                  onSaved: (email) {},
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                  decoration: InputDecoration(
                    hintText: "كلمة السر",
                    filled: true,
                    errorStyle: const TextStyle(color: Colors.red),
                    errorText: _isNotValidateP ? "أدخل كلمة السر " : null,
                    fillColor: const Color(0xffeef8f9),
                    iconColor: kPrimaryColor,
                    prefixIconColor: kPrimaryColor,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding,
                      vertical: defaultPadding,
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Icon(Icons.lock),
                    ),
                    hintStyle: const TextStyle(color: Colors.grey),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                      child: Icon(
                        isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: DropdownButtonFormField<String>(
                    value: selectedCity,
                    onChanged: (newValue) {
                      setState(() {
                        selectedCity = newValue;
                      });
                    },
                    items: cities.map<DropdownMenuItem<String>>((String city) {
                      return DropdownMenuItem<String>(
                        value: city,
                        child: Text(
                          city,
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      hintText: "اختر مدينتك",
                      errorStyle: const TextStyle(color: Colors.red),
                      errorText: _isNotValidateCity ? "اختر مدينتك " : null,
                      filled: true,
                      fillColor: const Color(0xffeef8f9),
                      iconColor: kPrimaryColor,
                      prefixIconColor: kPrimaryColor,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Padding(
                        padding: EdgeInsets.all(12),
                        child: Icon(Icons.home),
                      ),
                      hintStyle: const TextStyle(color: Colors.grey),
                    ),
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                    dropdownColor: const Color(0xffeef8f9),
                  ),
                ),
              ),
              const SizedBox(height: defaultPadding / 2),
              ElevatedButton(
                onPressed: () {
                  isLoading ? null : registUser();
                  isLoading
                      ? const CircularProgressIndicator()
                      : const Text("إنشاء حساب");
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: kPrimaryColor,
                  shape: const StadiumBorder(),
                  maximumSize: const Size(double.infinity, 56),
                  minimumSize: const Size(double.infinity, 56),
                ),
                child: Text(
                  "إنشاء حساب ".toUpperCase(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: defaultPadding / 2),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const SignUpScreenCom();
                      },
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: kPrimaryColor,
                  shape: const StadiumBorder(),
                  maximumSize: const Size(double.infinity, 56),
                  minimumSize: const Size(double.infinity, 56),
                ),
                child: Text(
                  " إنضم كمؤسسة ".toUpperCase(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: defaultPadding),
              AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const LoginScreen();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
