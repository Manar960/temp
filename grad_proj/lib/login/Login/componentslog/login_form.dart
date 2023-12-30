import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../admin/pages/home_page.dart';
import '../../../config.dart';
import '../../../timeelinee/screens/home/home_screen.dart';
import '../../../usrTime/screens/home/home_screen.dart';
import '../../Signup/components/signup_form.dart';
import '../../components/already_have_an_account_acheck.dart';
import '../../constantslog.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? emailError;
  String? passwordError;
  bool _isLoading = false;
  bool _isPasswordVisible = false;

  late SharedPreferences prefs;
  bool isAdmin = false;
  bool isUser = false;
  bool isCompany = false;

  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> loginAdmin() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });
      String admeal = emailController.text;
      var regBody = {
        "email": emailController.text,
        "password": passwordController.text,
      };
      var response = await http.post(Uri.parse(loginadmin),
          headers: {
            "Access-Control-Allow-Origin": "*",
            'Content-Type': 'application/json',
            'Accept': '*/*'
          },
          body: jsonEncode(regBody));

      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status']) {
        var myToken = jsonResponse['token'];
        prefs.setString('token', myToken);

        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) {
            return HomePageadmin(
              adminEmail: emailController.text,
            );
          }),
        );
      } else {
        setState(() {
          emailError = "البريد الإلكتروني أو كلمة المرور غير صحيحة";
          _isLoading = false;
        });
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
        emailError = "البريد الإلكتروني وكلمة المرور مطلوبة";
        _isLoading = false;
      });
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
  }

  Future<void> loginUser() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });

      var regBody = {
        "email": emailController.text,
        "password": passwordController.text,
      };
      var response = await http.post(Uri.parse(login),
          headers: {
            "Access-Control-Allow-Origin": "*",
            'Content-Type': 'application/json',
            'Accept': '*/*'
          },
          body: jsonEncode(regBody));
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status']) {
        var myToken = jsonResponse['token'];
        prefs.setString('token', myToken);
        prefs.setString('email', emailController.text);

        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return const HomeScreencomu();
          }),
        );
      } else {
        setState(() {
          emailError = "البريد الإلكتروني أو كلمة المرور غير صحيحة";
          _isLoading = false;
        });
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
        emailError = "البريد الإلكتروني وكلمة المرور مطلوبة";
        _isLoading = false;
      });
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
  }

  Future<void> loginCompany() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });

      var regBody = {
        "email": emailController.text,
        "password": passwordController.text,
      };

      var response = await http.post(Uri.parse(loginCompanyu),
          headers: {
            "Access-Control-Allow-Origin": "*",
            'Content-Type': 'application/json',
            'Accept': '*/*'
          },
          body: jsonEncode(regBody));
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status']) {
        var myToken = jsonResponse['token'];
        var companyName = jsonResponse['userEmail'];

        prefs.setString('token', myToken);
        prefs.setString('company', companyName);
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return const HomeScreencom();
          }),
        );
      } else {
        setState(() {
          emailError = "البريد الإلكتروني أو كلمة المرور غير صحيحة";
          _isLoading = false;
        });
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
        emailError = "البريد الإلكتروني وكلمة المرور مطلوبة";
        _isLoading = false;
      });
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
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          const Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              "تسجيل الدخول",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16.0),
          Directionality(
            textDirection: TextDirection.rtl,
            child: TextFormField(
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              onSaved: (email) {},
              decoration: InputDecoration(
                hintText: "البريد الإلكتروني",
                filled: true,
                errorText: emailError,
                fillColor: const Color(0xffeef8f9),
                prefixIconColor: kPrimaryColor,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.person),
                ),
                hintStyle: const TextStyle(color: Colors.grey),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                controller: passwordController,
                textInputAction: TextInputAction.done,
                obscureText: !_isPasswordVisible,
                cursorColor: kPrimaryColor,
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
                decoration: InputDecoration(
                  hintText: "كلمة المرور",
                  filled: true,
                  errorText: passwordError,
                  fillColor: const Color(0xffeef8f9),
                  iconColor: kPrimaryColor,
                  prefixIconColor: kPrimaryColor,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 16.0),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.lock),
                  ),
                  hintStyle: const TextStyle(color: Colors.grey),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              _buildRoleButton("مسؤول", isAdmin, () {
                setState(() {
                  isAdmin = true;
                  isUser = false;
                  isCompany = false;
                });
              }),
              _buildRoleButton("عميل", isUser, () {
                setState(() {
                  isAdmin = false;
                  isUser = true;
                  isCompany = false;
                });
              }),
              _buildRoleButton("شركة", isCompany, () {
                setState(() {
                  isAdmin = false;
                  isUser = false;
                  isCompany = true;
                });
              }),
            ],
          ),
          const SizedBox(height: 8.0),
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : ElevatedButton(
                  onPressed: () {
                    if (isAdmin) {
                      loginAdmin();
                    } else if (isUser) {
                      loginUser();
                    } else if (isCompany) {
                      loginCompany();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: kPrimaryColor,
                    shape: const StadiumBorder(),
                    maximumSize: const Size(double.infinity, 56),
                    minimumSize: const Size(double.infinity, 56),
                  ),
                  child: Text(
                    "سجل الدخول".toUpperCase(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: true,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SignUpScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRoleButton(String text, bool selected, VoidCallback onPressed) {
    return Expanded(
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: selected ? kPrimaryColor : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(
              color: selected ? kPrimaryColor : Colors.grey,
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: selected ? Colors.white : kPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
