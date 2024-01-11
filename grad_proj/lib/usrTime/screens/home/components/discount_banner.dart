import 'package:flutter/material.dart';

import '../../../../constants.dart';

class DiscountBanner extends StatelessWidget {
  const DiscountBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: bluebasic,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Directionality(
        textDirection: TextDirection.rtl,
        child: Text(
          "أهلا فيك\nكل اللي بدك اياه عنا",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
