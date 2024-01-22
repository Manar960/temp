import 'dart:convert';
import 'package:grad_proj/constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class EditRatingDialog extends StatelessWidget {
  final String userName;
  final String com;
  final Function(String) onCommentChanged;

  EditRatingDialog({super.key, 
    required this.userName,
    required this.onCommentChanged, 
    required this.com,

  }): commentController = TextEditingController(text: com);
 Future<void> addcomment(String UserName,String Name,String comment) async {
    const url = 'http://localhost:4000/Rating/comment-For/company';

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
         "UserName":UserName,
        "Name":Name,
        "comComment":comment,
      }),
    );
    if (response.statusCode == 200) {
      print(' successfully');
    } else {
      print('Failed ');
    }
  }
  final TextEditingController commentController;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('التعليق',  textDirection: TextDirection.rtl,),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [ 
          Text('الرد على $userName!',  textDirection: TextDirection.rtl,),
          const SizedBox(height: 10),
       TextField(
            style: const TextStyle(fontSize: 15),
            decoration: const InputDecoration(
              hintText: 'ردك',
             hintTextDirection: TextDirection.rtl,

            ),
            onChanged: onCommentChanged,
            maxLines: 2,
            textDirection: TextDirection.rtl,
            controller: commentController,
          ),
        ],
      ),
      actions: [
        Center(
          child: ElevatedButton(
            onPressed: () {
            addcomment(userName,com,comment);
              Navigator.of(context).pop(); 
            },
            child: const Text('ارسال',style: TextStyle(color: bluebasic),),
          ),
        ),
      ],
    );
  }
}

  String comment = '';
void showeditRatingDialog1(BuildContext context, String userName, String com) {

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return EditRatingDialog(
        userName: userName,
        com:com,
        onCommentChanged: (newComment) {
          comment = newComment;
        }
      );
      
    },
    
  );
}
