// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';

import '../utils/theme_selector.dart';

class BulletPoint extends StatelessWidget {
  const BulletPoint(
      {required Key key,
      required this.text,
      required this.animationController,
      required this.index})
      : super(key: key);
  final String text;
  final AnimationController animationController;
  final int index;

  @override
  // ignore: duplicate_ignore
  Widget build(BuildContext context) {
    double _animationStart = 0.1 * index;
    double _animationEnd = _animationStart + 0.4;
    return SlideTransition(
      position:
          Tween<Offset>(begin: const Offset(2, 0), end: const Offset(0, 0))
              .animate(CurvedAnimation(
                  parent: animationController,
                  curve: Interval(_animationStart, _animationEnd,
                      curve: Curves.ease))),
      child: FadeTransition(
        opacity: animationController,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              String.fromCharCode(0x2022),
              style: TextStyle(
                  color: const Color(0xff063970),
                  fontSize: ThemeSelector.selectBodyText(context)!.fontSize),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.01),
            Flexible(
              child: Text(
                text,
                style: ThemeSelector.selectBodyText(context),
              ),
            )
          ],
        ),
      ),
    );
  }
}
