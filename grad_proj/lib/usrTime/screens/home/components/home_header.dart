import 'package:flutter/material.dart';

import '../../chat/modules/main_page.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(child: SearchField()),
          const SizedBox(width: 16),
          IconBtnWithCounter(
              svgSrc: "assets/icon/message-circle-dots-svgrepo-com.svg",
              press: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return const MainPagemsg();
                    }),
                  )),
          const SizedBox(width: 8),
          IconBtnWithCounter(
            svgSrc: "assets/icon/Bell.svg",
            numOfitem: 3,
            press: () {},
          ),
        ],
      ),
    );
  }
}
