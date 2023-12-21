import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

import '../utils/theme_selector.dart';
import '../utils/view_wrapper.dart';
import '../widgets/bullet_list.dart';
import '../widgets/navigation_arrow.dart';

class AboutView extends StatefulWidget {
  const AboutView({required Key key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AboutViewState createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView>
    with SingleTickerProviderStateMixin {
  late double screenWidth;
  late double screenHeight;
  String loremIpsum =
      'قم بطلب سلعة ، او أطلب بدا خدمة من منزلك أحجز و قم بالدفع ';
  String loremIpsum1 =
      ' تتبع طلبك وراقب كل تفاصيل موقعه و آلية سيره بحذافيرها عبر شاشة جهازك دون أي مجهود';
  String loremIpsum2 =
      'أحصل على استشارة الخبراء و كن على دراية بكافة المستلزمات و الإجراءات قبل أي عملية ';
  String loremIpsum3 =
      ' احصل على أفضل الاسعار في اقرب نقطة عليك عن طريق الاقتراحات ';
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return ViewWrapper(
      desktopView: desktopView(),
      mobileView: mobileView(),
      key: const Key('34'),
    );
  }

  Widget desktopView() {
    return Stack(
      children: [
        const NavigationArrow(
          isBackArrow: false,
          key: Key('31'),
        ),
        const NavigationArrow(
          isBackArrow: true,
          key: Key('30'),
        ),
        Directionality(
          textDirection: TextDirection
              .rtl, // Set the text direction to right-to-left (rtl)
          child: Align(
              alignment:
                  Alignment.centerRight, // Align the children to the right
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .end, // Move the widgets to the end (right)
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(flex: 1),
                  Expanded(flex: 3, child: infoSection()),
                  const Spacer(flex: 1),
                  Directionality(
                      textDirection: TextDirection
                          .rtl, // Set the text direction to right-to-left (rtl)
                      child: Expanded(
                          flex: 3,
                          child: BulletList(
                            strings: [
                              loremIpsum,
                              loremIpsum1,
                              loremIpsum2,
                              loremIpsum3
                            ],
                            key: const Key('29'),
                            textAlign: TextAlign.right,
                          ))),
                  const Spacer(flex: 1),
                ],
              )),
        )
      ],
    );
  }

  Widget mobileView() {
    return Column(
      children: [
        SizedBox(height: screenHeight * 0.05),
        infoText(),
        SizedBox(height: screenHeight * 0.05),
        SizedBox(
          height: screenHeight * 0.3,
          child: BulletList(
            strings: [loremIpsum, loremIpsum1, loremIpsum2, loremIpsum3],
            textAlign: TextAlign.right,
            key: const Key('28'),
          ),
        ),
      ],
    );
  }

  Widget infoSection() {
    return SizedBox(
      width: screenWidth * 0.35,
      child: Column(
        children: [
          space(),
          profilePicture(),
          SizedBox(height: screenHeight * 0.05),
          infoText()
        ],
      ),
    );
  }

  Widget space() {
    return SizedBox(width: getImageSize() * 0.5);
  }

  Widget profilePicture() {
    return SizedBox(
      height: getImageSize(),
      width: getImageSize(),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(getImageSize() / 2),
          child: Container(
            color: Colors.grey,
            child: Center(
              child: Lottie.asset('assets/about.json'),
            ),
          )),
    );
  }

  double getImageSize() {
    if (screenWidth > 1600 && screenHeight > 800) {
      return 330;
    } else if (screenWidth > 1300 && screenHeight > 600) {
      return 280;
    } else if (screenWidth > 1000 && screenHeight > 400) {
      return 180;
    } else {
      return 130;
    }
  }

  Widget infoText() {
    return Text(
      'قم بالتسجيل كمستخدم عادي لتحصل على تجربة رائعة و تمتع بمزايا رائعة و غير محدودة ، أو سجل خدمتك لدينا لتحصل على زبائن من كافة انحاء الضفة اعرض ما لديكو كن  من ',
      overflow: TextOverflow.clip,
      textAlign: TextAlign.right,
      style: ThemeSelector.selectBodyText(context),
    );
  }
}
