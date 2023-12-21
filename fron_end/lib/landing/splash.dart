import 'package:flutter/material.dart';

import 'package:splash_screen_view/SplashScreenView.dart';

import 'info.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SplashScreenView(
          navigateRoute: const OnboardingScreen(),
          duration: 5000,
          imageSize: 130,
          text: "WHEELS WELL",
          textType: TextType.ColorizeAnimationText,
          textStyle: const TextStyle(
            fontSize: 40.0,
          ),
          colors: const [
            Color(0XFF1e81b0),
            Color(0XFFabdbe3),
            Color(0XFFeab676),
          ],
          backgroundColor: Colors.white,
        ),
        Positioned(
          top: 120,
          left: 0,
          right: 0,
          child: Image.asset("assets/logo.png"),
        ),
      ],
    );
  }
}
