import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Align(
      alignment: Alignment.centerLeft, // Align the widget to the left
      child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 2,
              width: screenWidth * 0.9,
              color: const Color(0xffeab676),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.05,
            child: Padding(
              padding: EdgeInsets.only(
                  left: screenWidth * 0.05, right: screenWidth * 0.05),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Made with Flutter Web \u00a9 2023',
                      style:
                          TextStyle(color: Colors.black, fontFamily: 'Barlow'))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
