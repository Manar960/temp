import 'package:flutter/material.dart';
import '../../../constants.dart';

class methoud extends StatelessWidget {
  final String title;
  final bool isactive;
  const methoud({Key? key, required this.title, required this.isactive})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: isactive == true ? bluecolor : bluecolor.withOpacity(0.4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(title,
          style: const TextStyle(
              color: Colors.white, height: 1, fontWeight: FontWeight.bold)),
    );
  }
}
