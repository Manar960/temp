import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({super.key, required this.controller, required this.tabs});

  final TabController controller;
  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double tabBarScaling = screenWidth > 1400
        ? 0.21
        : screenWidth > 1100
            ? 0.3
            : 0.4;
    return Padding(
      padding: EdgeInsets.only(right: screenWidth * 0.05),
      child: SizedBox(
        width: screenWidth * tabBarScaling,
        child: Theme(
          data: ThemeData(
              highlightColor: const Color(0xffeab676),
              splashColor: Colors.black,
              hoverColor: Colors.black),
          child: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            controller: controller,
            indicatorColor: const Color(0xff063970),
            tabs: tabs,
          ),
        ),
      ),
    );
  }
}
