import 'package:flutter/material.dart';

import '../../../constants.dart';

class waytodelivary extends StatelessWidget {
  final IconData icon;
  final bool isactive;
  final String title;
  final Color pcolor;
  const waytodelivary(
      {Key? key,
      required this.icon,
      required this.isactive,
      required this.title,
      required this.pcolor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 120,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: isactive ? pcolor : null,
          border: Border.all(color: pcolor)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 80, color: isactive ? Colors.white : pcolor),
          Text(
            title,
            style: TextStyle(
                color: isactive ? Colors.white : bluecolor,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
