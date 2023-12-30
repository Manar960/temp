import 'package:flutter/material.dart';

import '../../../common/app_colors.dart';

class NotificationCardWidget extends StatelessWidget {
  const NotificationCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final currentTime = DateTime.now();
    final isMorning = currentTime.hour > 12;

    String greetingText = !isMorning ? "صباح الخير" : "مساء الخير";
    String messageText = !isMorning
        ? "👋 أهلا بعودتك \n 👑أنجز المهام و أجعل يومك مميز  \n لا تنسى مراجعة كافة الأقسام ، و تدقيق الطلبات ، و فحص تعليقات المستخدمين \n💙من من رائع رؤيتك في وقت عملك"
        : "👋 أهلا بعودتك \n 👑أنجز المهام و أجعل ليلتك حماسية \n لا تنسى مراجعة كافة الأقسام ، و تدقيق الطلبات ، و فحص تعليقات المستخدمين \n💙من من رائع رؤيتك في وقت عملك";
    String imageAsset = !isMorning ? "assets/m.png" : "assets/n.png";

    return Container(
      decoration: BoxDecoration(
        color: AppColor.yellow,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (MediaQuery.of(context).size.width >= 620) ...{
            Image.asset(
              imageAsset,
              height: 160,
            ),
            const SizedBox(width: 20),
          },
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text.rich(
                  TextSpan(
                    style: TextStyle(fontSize: 16, color: AppColor.white),
                    children: [
                      TextSpan(
                          text: greetingText,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  messageText,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColor.white,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
