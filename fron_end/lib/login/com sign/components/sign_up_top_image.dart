import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../constantslog.dart';

class SignUpScreenTopImage extends StatelessWidget {
  const SignUpScreenTopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Directionality(
            textDirection:
                TextDirection.rtl, // Set text direction to left-to-right (ltr)
            child: Text(
              "إنشاء حساب ".toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            )),
        const SizedBox(height: defaultPadding),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: Lottie.asset("assets/any.json"),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: defaultPadding),
      ],
    );
  }
}
