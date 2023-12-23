import 'package:flutter/material.dart';
import '../constantslog.dart';

class SignUpScreenTopImagecom extends StatelessWidget {
  const SignUpScreenTopImagecom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: defaultPadding),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: Image.asset(
                "assets/any.png", width: 600, // Width of the image
                height: 600,
              ),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: defaultPadding),
      ],
    );
  }
}
