import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    required this.title,
    required this.press,
    this.showSeeAllButton = true,
  }) : super(key: key);

  final String title;
  final GestureTapCallback press;
  final bool showSeeAllButton;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Visibility(
          visible:
              showSeeAllButton, // Set visibility based on the boolean property
          child: TextButton(
            onPressed: press,
            child: const Text(
              "عرض المزيد",
            ),
            style: TextButton.styleFrom(foregroundColor: Colors.grey),
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
