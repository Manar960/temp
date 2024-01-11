import 'package:flutter/material.dart';

class QuizQuestion extends StatelessWidget {
  final String image;
  final String question;
  final List<String> options;

  const QuizQuestion({
    Key? key,
    required this.image,
    required this.question,
    required this.options,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: EdgeInsets.all(16),
      child: Card(
        child: Column(
          children: [
            Image.asset(image, height: 200, width: 300, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(question,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  // خيارات الاختبار هنا
                  for (String option in options)
                    RadioListTile<String>(
                      title: Text(option),
                      value: option,
                      groupValue: null,
                      onChanged: (value) {},
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
