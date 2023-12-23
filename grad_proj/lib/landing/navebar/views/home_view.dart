import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:lottie/lottie.dart';

import '../utils/theme_selector.dart';
import '../utils/view_wrapper.dart';
import '../widgets/navigation_arrow.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late double screenWidth;
  late double screenHeight;
  late String ali;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return ViewWrapper(
      desktopView: desktopView(),
      mobileView: mobileView(),
      key: const Key('2'),
    );
  }

  Widget desktopView() {
    return Stack(
      children: [
        const NavigationArrow(
          isBackArrow: false,
          key: Key('15'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Directionality(
                textDirection: TextDirection.rtl,
                child: SizedBox(
                  width: screenWidth * 0.45,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      header(getFontSize(true)),
                      SizedBox(height: screenHeight * 0.05),
                      subHeader('خدمات للسيارات ', getFontSize(false)),
                      SizedBox(height: screenHeight * 0.01),
                      subHeader('سلع للسيارات ', getFontSize(false)),
                      SizedBox(height: screenHeight * 0.01),
                      subHeader('مزايا رائعة لتجربة مستخدم ممتازة',
                          getFontSize(false)),
                      SizedBox(height: screenHeight * 0.1),
                    ],
                  ),
                )),
            SizedBox(width: screenWidth * 0.03),
            profilePicture()
          ],
        )
      ],
    );
  }

  Widget mobileView() {
    return Column(
      children: [
        profilePicture(),
        SizedBox(height: screenHeight * 0.02),
        header(30),
        SizedBox(height: screenHeight * 0.01),
        subHeader('خدمات - سلع - مزايا متنوعة', 15)
      ],
    );
  }

  double getImageSize() {
    if (screenWidth > 1600 && screenHeight > 800) {
      return 400;
    } else if (screenWidth > 1300 && screenHeight > 600) {
      return 350;
    } else if (screenWidth > 1000 && screenHeight > 400) {
      return 300;
    } else {
      return 250;
    }
  }

  double getFontSize(bool isHeader) {
    double fontSize = screenWidth > 950 && screenHeight > 550 ? 30 : 25;
    return isHeader ? fontSize * 2.25 : fontSize;
  }

  Widget profilePicture() {
    return SizedBox(
      height: getImageSize(),
      width: getImageSize(),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(getImageSize() / 2),
          child: Lottie.asset(
            'assets/home.json',
            fit: BoxFit.cover,
          )),
    );
  }

  Widget header(double fontSize) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: RichText(
        text: TextSpan(
          style: ThemeSelector.selectHeadline(context),
          children: const <TextSpan>[
            TextSpan(text: 'أهلا بك في عالم  '),
            TextSpan(
                text: 'السيارات ',
                style: TextStyle(
                  color: Color(0xff063970),
                )),
          ],
        ),
      ),
    );
  }

  Widget subHeader(String text, double fontSize) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Text(text, style: ThemeSelector.selectSubHeadline(context)));
  }
}
