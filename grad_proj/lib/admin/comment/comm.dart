import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../config.dart';
import '../common/app_colors.dart';
import '../common/app_responsive.dart';
import '../pages/dashboard/widget/header_widget.dart';

class CommentList extends StatefulWidget {
  const CommentList({Key? key}) : super(key: key);

  @override
  _CommentListState createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  List<Map<String, String>> comments = [];

  @override
  void initState() {
    super.initState();
    fetchComments();
  }

  Future<void> fetchComments() async {
    try {
      final response = await http.get(Uri.parse("$adminComm/a"));
      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedData = json.decode(response.body);
        final List<dynamic> commentsData = decodedData['comments'];

        setState(() {
          comments =
              List<Map<String, String>>.from(commentsData.map((dynamic item) {
            return Map<String, String>.from(item.map((key, value) {
              return MapEntry(key, value.toString());
            }));
          }));
        });
      } else {
        throw Exception('Failed to load comments');
      }
    } catch (e) {
      print('Error fetching comments: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var comment in comments)
              CommentCard(
                username: comment['UserEmail'] ?? '',
                comment: comment['Comment'] ?? '',
                // userImage:
                // 'assets/default_user_image.jpg', // Replace with actual image path
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
  // final String userImage;

  const CommentCard({
    Key? key,
    required this.username,
    required this.comment,
    //required this.userImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        leading: IconButton(
          icon: const Icon(Icons.message),
          onPressed: () {
            // Add the code you want to execute when the button is pressed
          },
        ),
        trailing: CircleAvatar(
          backgroundImage: AssetImage(""),
        ),
        title: Text(
          username,
          textDirection: TextDirection.rtl,
        ),
        subtitle: Text(
          comment,
          textDirection: TextDirection.rtl,
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
