import 'package:flutter/material.dart';

import 'QuizQuestion.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('صفحة الاختبار'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QuizQuestion(
              image: "assets/images/question1.jpg",
              question: "ما هو السؤال الأول؟",
              options: ["خيار 1", "خيار 2", "خيار 3", "خيار 4"],
            ),
            // ... الأسئلة الأخرى هنا
          ],
        ),
      ),
    );
  }
}
