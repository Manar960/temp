import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grad_proj/constants.dart';

class Storse extends StatefulWidget {
  const Storse({
    Key? key,
    required this.image,
    required this.title,
    required this.press,
    required this.location,
    this.cardColor,
  }) : super(key: key);

  final String image, title, location;
  final VoidCallback press;
  final Color? cardColor;

  @override
  _StorseState createState() => _StorseState();
}

class _StorseState extends State<Storse> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.press,
      onHover: (value) {
        setState(() {
          isHover = value;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        height: 320,
        width: 540,
        decoration: BoxDecoration(
          color: widget.cardColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [if (isHover) kDefaultCardShadow],
        ),
        child: Stack(
          children: [
            Row(
              children: [
                Image.asset(widget.image),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(widget.location),
                        SizedBox(height: 10),
                        Text(
                          widget.title,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(height: 1.5),
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: FloatingActionButton(
                onPressed: widget.press,
                child: const Icon(CupertinoIcons.chevron_right,
                    color: Color.fromARGB(255, 246, 121, 121)),
                backgroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
