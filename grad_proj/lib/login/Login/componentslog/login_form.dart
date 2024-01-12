import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../admin/pages/home_page.dart';
import '../../../config.dart';
import '../../../timeelinee/screens/home/home_screen.dart';
import '../../../usrTime/screens/home/home_screen.dart';
import '../../Signup/components/signup_form.dart';
import '../../components/already_have_an_account_acheck.dart';
import '../../constantslog.dart';
import '../../provider/UserProvider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController sendResetCodeUrl = TextEditingController();
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

  void forgotPassword() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "نسيت كلمة المرور؟",
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue, // Customize color
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16.0),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    controller: emailController,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      labelText: "البريد الإلكتروني",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    sendResetCode(emailController.text);
                    Navigator.pop(context);
                    _showPasswordField();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Customize button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    "إرسال الرمز",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showPasswordField() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "إعادة تعيين كلمة المرور",
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue, // Customize color
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16.0),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    controller: codeController,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      labelText: "الرمز",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200], // Customize fill color
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    controller: passwordController,
                    obscureText: !_isPasswordVisible,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      labelText: "كلمة المرور الجديدة",
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
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200], // Customize fill color
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    resetPassword(codeController.text, passwordController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Customize button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    "تأكيد",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> sendResetCode(String email) async {
    try {
      var response = await http.post(
        Uri.parse(code),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'email': email}),
      );

      var jsonResponse = jsonDecode(response.body);
      if (!jsonResponse['status']) {
        // ignore: avoid_print
        print("Failed to send reset code.");
      }
    } catch (error) {
      // ignore: avoid_print
      print("Error sending reset code: $error");
    }
  }

  Future<void> resetPassword(String code, String newPassword) async {
    try {
      var response = await http.post(
        Uri.parse(resetPasswordUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'code': code,
          'newPassword': newPassword,
        }),
      );

      var jsonResponse = jsonDecode(response.body);
      if (!jsonResponse['status']) {
      } else {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        // ignore: avoid_print
        print("Password reset successfully");
      }
    } catch (error) {
      // ignore: avoid_print
      print("Error resetting password: $error");
    }
  }

  Future<void> loginAdmin() async {
    String? tokenAdmin = await FirebaseMessaging.instance.getToken();
    FirebaseMessaging.instance.getToken().then((value) {
      String? tokenAdmin = value;
    });
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });
      // ignore: unused_local_variable
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
      }
    } else {
      setState(() {
        emailError = "البريد الإلكتروني وكلمة المرور مطلوبة";
      });
    }
  }

  Future<void> loginUser() async {
    String? tokenUser = await FirebaseMessaging.instance.getToken();
    FirebaseMessaging.instance.getToken().then((value) {
      String? tokenUser = value;
    });
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
        var username = jsonResponse['userName'];
        prefs.setString('token', myToken);
        prefs.setString('email', emailController.text);
        prefs.setString('userName', username);
        Provider.of<UserProvider>(context, listen: false).setUserName(username);
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return const HomeScreenu();
          }),
        );
      } else {
        setState(() {
          emailError = "البريد الإلكتروني أو كلمة المرور غير صحيحة";
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        emailError = "البريد الإلكتروني وكلمة المرور مطلوبة";
      });
    }
  }

  Future<void> loginCompany() async {
    String? tokenCom = await FirebaseMessaging.instance.getToken();
    FirebaseMessaging.instance.getToken().then((value) {
      String? tokenCom = value;
    });
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
        // ignore: avoid_print
        print(companyName);
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
      }
    } else {
      setState(() {
        emailError = "البريد الإلكتروني وكلمة المرور مطلوبة";
      });
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
          Container(
            margin: const EdgeInsets.only(top: defaultPadding),
            child: TextButton(
              onPressed: () {
                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  forgotPassword();
                });
              },
              child: const Text(
                "هل نسيت كلمة المرور؟",
                style: TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
