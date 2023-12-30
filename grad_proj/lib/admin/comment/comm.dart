import 'package:flutter/material.dart';

import '../common/app_colors.dart';
import '../common/app_responsive.dart';
import '../pages/dashboard/widget/header_widget.dart';

class CommentList extends StatelessWidget {
  const CommentList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColor.bgColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (AppResponsive.isTablet(context) ||
                AppResponsive.isDesktop(context))
              const CommentCard(
                username: 'مستخدم 1',
                comment: 'هذا تعليق رقم 1',
                userImage: 'assets/user1.jpg',
              ),
            if (AppResponsive.isTablet(context) ||
                AppResponsive.isDesktop(context))
              const CommentCard(
                username: 'مستخدم 2',
                comment: 'هذا تعليق رقم 2',
                userImage: 'assets/user2.jpg',
              ),
            if (AppResponsive.isMobile(context))
              const CommentCard(
                username: 'مستخدم 1',
                comment: 'هذا تعليق رقم 1',
                userImage: 'assets/user1.jpg',
              ),
            if (AppResponsive.isMobile(context))
              const CommentCard(
                username: 'مستخدم 2',
                comment: 'هذا تعليق رقم 2',
                userImage: 'assets/user2.jpg',
              ),
          ],
        ),
      ),
    );
  }
}

class CommentCard extends StatelessWidget {
  final String username;
  final String comment;
  final String userImage;

  const CommentCard({super.key, 
    required this.username,
    required this.comment,
    required this.userImage,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(userImage),
        ),
        title: Text(username),
        subtitle: Text(comment),
        trailing: IconButton(
          icon: const Icon(Icons.message),
          onPressed: () {
            // أدخل هنا الشيفرة التي تريد تنفيذها عند النقر على الزر
          },
        ),
      ),
    );
  }
}

class CommentPage extends StatefulWidget {
  const CommentPage({super.key});

  @override
  _CommentPage createState() => _CommentPage();
}

class _CommentPage extends State<CommentPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColor.bgColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          /// Header Part
          const HeaderWidget(
            title: 'Comments',
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Column(
                        children: [
                          const CommentList(),
                          const SizedBox(
                            height: 20,
                          ),
                          if (AppResponsive.isMobile(context)) ...{
                            const SizedBox(
                              height: 20,
                            ),
                          },
                        ],
                      ),
                    ),
                  ),
                  if (!AppResponsive.isMobile(context))
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: const Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
