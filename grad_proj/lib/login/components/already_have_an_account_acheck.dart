import 'package:flutter/material.dart';

import '../constantslog.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function? press;
  const AlreadyHaveAnAccountCheck({
    Key? key,
    this.login = true,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Directionality(
          textDirection:
              TextDirection.rtl, // Set text direction to left-to-right (ltr)
          child: Text(
            login ? " أنشاء حساب" : "تسجيل دخول",
            style: const TextStyle(color: kPrimaryColor),
          ),
        ),
        GestureDetector(
            onTap: press as void Function()?,
            child: Directionality(
              textDirection: TextDirection
                  .rtl, // Set text direction to left-to-right (ltr)
              child: Text(
                login ? " ليس لديك حساب ؟" : "لديك حساب  ؟ ",
                style: const TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ))
      ],
    );
  }
}
