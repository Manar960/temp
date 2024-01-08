import 'package:flutter/material.dart';

import '../../../constants.dart';

class Cards extends StatelessWidget {
  final String image;
  final bool isactive;
  final String title;
  final String number;

  const Cards({
    Key? key,
    required this.image,
    required this.isactive,
    required this.title,
    required this.number,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: isactive ? Colors.white : Color.fromARGB(255, 233, 240, 246),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isactive ? bluecolor : Color.fromARGB(255, 233, 240, 246),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                image,
                height: 50,
                width: 50,
              ),
              SizedBox(width: 15),
              for (int i = 0; i < 4; i++)
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 2),
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                ),
              SizedBox(width: 15),
              Text(
                number.toString(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          if (isactive)
            Align(
              alignment: Alignment.bottomRight,
              child: Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
            ),
        ],
      ),
    );
  }
}
