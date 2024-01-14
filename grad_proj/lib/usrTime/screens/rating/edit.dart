import 'dart:convert';
import 'package:grad_proj/constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../booking/boking_screen.dart';

class EditRatingDialog extends StatelessWidget {
  final String userName;
  final String userImage;
    final String com;
    final Map<String, dynamic> item;

  final Function(double) onRatingChanged;
  final Function(String) onCommentChanged;
  final double rate;
  EditRatingDialog({super.key, 
    required this.userName,
    required this.userImage,
    required this.onRatingChanged,
    required this.onCommentChanged, 
    required this.rate, required this.com, required this.item,

  }): commentController = TextEditingController(text: com);
 Future<void> addRate( String UserName,String StoreName,double rate,String comment) async {
    const url = 'https://gp-back-gp.onrender.com/Rating/AddRating-For/Store';

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "UserName":UserName,
        "Name":StoreName,
        "Rateing":rate,
        "Comments":comment,
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
      title: const Text('تقييم هذا المتجر',  textDirection: TextDirection.rtl,),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: Image.asset(userImage).image,
          ),
          const SizedBox(height: 10),
          Text('أهلاً, $userName!',  textDirection: TextDirection.rtl,),
          const SizedBox(height: 10),
          RatingBar.builder(
            initialRating: rate,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 5,
            itemSize: 30.0,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: onRatingChanged,
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 10),
          TextField(
            style: const TextStyle(fontSize: 15),
            decoration: const InputDecoration(
              hintText: 'صف تجربتك',
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
            addRate(username!,item['Name'],rating,comment);
              Navigator.of(context).pop(); 
            },
            child: const Text('تعديل',style: TextStyle(color: bluebasic),),
          ),
        ),
      ],
    );
  }
}
  double rating = 0;
  String comment = '';
void showeditRatingDialog(BuildContext context, String userName, String userImage,double rate, String com,final Map<String, dynamic> item) {

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return EditRatingDialog(
        userName: userName,
        userImage: userImage,
        rate: rate,
        com:com,
        onRatingChanged: (newRating) {
          rating = newRating;
        },
        onCommentChanged: (newComment) {
          comment = newComment;
     
        }, item: item,
      );
      
    },
    
  );
}
