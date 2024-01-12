import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomDialog extends StatelessWidget {
  final String lottieAsset;
  final String textContent;

  // ignore: use_key_in_widget_constructors
  const CustomDialog({
    required this.lottieAsset,
    required this.textContent,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            width: 350,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                LottieBuilder.asset(
                  lottieAsset,
                  width: 150,
                  height: 150,
                  fit: BoxFit.fill,
                  repeat: false,
                  animate: true,
                ),
                const SizedBox(height: 16),
                Text(
                  textContent,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context); // Close the dialog
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              child: const Icon(
                Icons.close,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void showCards(BuildContext context, String lottieAsset, String textContent) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomDialog(
        lottieAsset: lottieAsset,
        textContent: textContent,
      );
    },
  );
}
