import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';

class BannerSection extends StatelessWidget {
  const BannerSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: AboutSection(),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          flex: 2,
          child: Column(
            children: [
              Image.asset("assets/images/carr.png"),
            ],
          ),
        )
      ],
    );
  }
}

class MobBanner extends StatefulWidget {
  const MobBanner({Key? key}) : super(key: key);

  @override
  _MobBannerState createState() => _MobBannerState();
}

class _MobBannerState extends State<MobBanner> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Image.asset(
              "assets/images/carr.png",
              height: 250,
              width: 400,
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        const AboutSection(),
      ],
    );
  }
}

class AboutSection extends StatefulWidget {
  const AboutSection({Key? key}) : super(key: key);

  @override
  _AboutSectionState createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  late String animatedText;
  int currentIndex = 0;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    animatedText = ''; 
    const String fullText = "خيارك الافضل ";

    timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        if (currentIndex < fullText.length) {
          animatedText += fullText[currentIndex];
          currentIndex++;
        } else {
          timer.cancel(); 
        }
      });
    });
  }

  @override
  void dispose() {
    timer.cancel(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AutoSizeText(
          animatedText,
          maxLines: 1,
          style: TextStyle(fontSize: 56, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}