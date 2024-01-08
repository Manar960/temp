import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';

class orderscards extends StatefulWidget {
  const orderscards({
    Key? key,
    required this.image,
    required this.title,
    required this.press,
    required this.price,
    this.cardColor,
    required this.press2,
  }) : super(key: key);

  final String image, title, price;
  final VoidCallback press, press2;
  final Color? cardColor;

  @override
  _orderscardsState createState() => _orderscardsState();
}

class _orderscardsState extends State<orderscards> {
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
        duration: const Duration(milliseconds: 200),
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
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.title,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(height: 1.5),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          "\$${widget.price}",
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
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
                onPressed: widget.press2,
                child: const Icon(CupertinoIcons.delete,
                    color: Color.fromARGB(255, 246, 121, 121)),
                backgroundColor: Colors.white, // Use your desired color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
