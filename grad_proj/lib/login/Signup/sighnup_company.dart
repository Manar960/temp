import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import '../../config.dart';
import '../Login/login_screen.dart';
import '../com sign/components/signup_form.dart';
import '../components/already_have_an_account_acheck.dart';
import '../components/background.dart';
import '../constantslog.dart';
import '../responsive.dart';
import 'components/sign_up_top_image.dart';
import 'package:http/http.dart' as http;

class SignUpScreenCom extends StatelessWidget {
  const SignUpScreenCom({Key? key}) : super(key: key);

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

  String selectedCity = cities[0]; // Default city

  bool _isObscure = true;
  String selectedType = "خدمات";

  bool _isNotValidateE = false;
  bool _isNotValidateN = false;
  bool _isNotValidateP = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  // ignore: non_constant_identifier_names
  void Applecation() async {
    if (emailController.text.isNotEmpty &&
        passController.text.isNotEmpty &&
        nameController.text.isNotEmpty) {
      var regBody = {
        "Name": nameController.text,
        "email": emailController.text,
        "password": passController.text,
        "Type": selectedType,
        "location": selectedCity,
        "Accsept": false
      };
      var response = await http.post(
        Uri.parse(join),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(regBody),
      );
      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const SignUpFormco();
            },
          ),
        );
      } else {
        // إذا كان هناك خطأ في الاستجابة من السيرفر
        Fluttertoast.showToast(
          msg: "تأكد من بياناتك ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
          webBgColor: "#e74c3c",
          webPosition: "center",
          timeInSecForIosWeb: 2,
        );
      }
    } else {
      setState(() {
        _isNotValidateE = emailController.text.isEmpty;
        _isNotValidateP = passController.text.isEmpty;
        _isNotValidateN = nameController.text.isEmpty;
      });
    }
  }

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
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 44, 44, 44)),
                ),
              ),
              const SizedBox(height: defaultPadding),
              Directionality(
                textDirection: TextDirection.rtl,
                child: TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  cursorColor: kPrimaryColor,
                  onSaved: (companyName) {},
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                  decoration: InputDecoration(
                    hintText: "اسم الشركة",
                    filled: true,
                    errorStyle: const TextStyle(color: Colors.red),
                    errorText: _isNotValidateN ? "أدخل أسم الشركة  " : null,
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
                      child: Icon(Icons.business),
                    ),
                    hintStyle: const TextStyle(color: Colors.grey),
                  ),
                ),
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
                        _isNotValidateE ? "أدخل البريد الإلكتروني   " : null,
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
                  controller: passController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  cursorColor: kPrimaryColor,
                  onSaved: (password) {},
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                    hintText: "كلمة المرور",
                    filled: true,
                    errorStyle: const TextStyle(color: Colors.red),
                    errorText: _isNotValidateP ? "أدخل كلمة السر   " : null,
                    fillColor: const Color(0xffeef8f9),
                    iconColor: kPrimaryColor,
                    prefixIconColor: kPrimaryColor,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    ),
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
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: DropdownButtonFormField<String>(
                    value: selectedType,
                    onChanged: (newValue) {
                      setState(() {
                        selectedType = newValue!;
                      });
                    },
                    items: ["خدمات", "بضائع"]
                        .map<DropdownMenuItem<String>>((String type) {
                      return DropdownMenuItem<String>(
                          value: type,
                          child: SizedBox(
                              height: 50,
                              child: Center(
                                child: Text(
                                  type,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                              )));
                    }).toList(),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xffeef8f9),
                      iconColor: kPrimaryColor,
                      prefixIconColor: kPrimaryColor,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Padding(
                        padding: EdgeInsets.all(12),
                        child: Icon(Icons.account_box),
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                    dropdownColor: const Color(0xffeef8f9),
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
                        selectedCity = newValue!;
                      });
                    },
                    items: cities.map<DropdownMenuItem<String>>((String city) {
                      return DropdownMenuItem<String>(
                          value: city,
                          child: SizedBox(
                            height: 50,
                            child: Center(
                              child: Text(
                                city,
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              ),
                            ),
                          ));
                    }).toList(),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xffeef8f9),
                      iconColor: kPrimaryColor,
                      prefixIconColor: kPrimaryColor,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Icon(Icons.home),
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    dropdownColor: const Color(0xffeef8f9),
                  ),
                ),
              ),
              const SizedBox(height: defaultPadding / 2),
              ElevatedButton(
                onPressed: Applecation,
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: kPrimaryColor,
                  shape: const StadiumBorder(),
                  maximumSize: const Size(double.infinity, 56),
                  minimumSize: const Size(double.infinity, 56),
                ),
                child: Text(
                  "إتمام الدفع".toUpperCase(),
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
