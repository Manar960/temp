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
          visible: showSeeAllButton,
          child: TextButton(
            onPressed: press,
            // ignore: sort_child_properties_last
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
