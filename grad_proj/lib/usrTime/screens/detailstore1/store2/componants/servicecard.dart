import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../../../../constants.dart';

class ServiceCard extends StatefulWidget {
  const ServiceCard({
    Key? key,
    required this.services,
    required this.index,
  }) : super(key: key);

  final List? services;
  final int index;

  @override
  _ServiceCardState createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  bool isHover = false;
  Duration duration = Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _showDescriptionDialog(context);
      },
      onHover: (value) {
        setState(() {
          isHover = value;
        });
      },
      hoverColor: Colors.transparent,
      child: AnimatedContainer(
        duration: duration,
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 53),
        height: 230,
        width: 230,
        decoration: BoxDecoration(
          color: bluecolor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [if (isHover) kDefaultCardShadow],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: duration,
              padding: EdgeInsets.all(20 * 1.5),
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  if (!isHover)
                    BoxShadow(
                      offset: Offset(0, 20),
                      blurRadius: 40,
                      color: Colors.black.withOpacity(0.1),
                    ),
                ],
              ),
              child:  LottieBuilder.asset(
                widget.services![widget.index]['image'],
                fit: BoxFit.cover,
                width: 100,
                height: 100,
              ),
            ),
            SizedBox(height: 20),
            Text(
              widget.services![widget.index]['name'],
              style: TextStyle(fontSize: 22),
            ),
          ],
        ),
      ),
    );
  }
  void _showDescriptionDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: contentBox(context),
      );
    },
  );
}

Widget contentBox(BuildContext context) {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      shape: BoxShape.rectangle,
      color: softwhite,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black,
          offset: Offset(0, 10),
          blurRadius: 10,
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "الوصف",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 15),
        Text(
          widget.services![widget.index]['description'],
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 20),
        Align(
          alignment: Alignment.bottomRight,
          child: TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "اغلاق",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

}