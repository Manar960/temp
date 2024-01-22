import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grad_proj/constants.dart';
import '../../../dialog.dart';
import '../booking/boking_screen.dart';
import 'edit.dart';
import 'rate.dart';
import 'package:http/http.dart' as http;
import 'package:readmore/readmore.dart';

class UserReviweCard extends StatefulWidget {
  const UserReviweCard({
    Key? key,
    required this.userName,
    required this.Date,
    required this.comment,
    required this.rate,
    required this.StoreName,
    required this.item,
    required this.comComment,
    required this.Datecom,
  }) : super(key: key);

  final String userName, Date, comment, StoreName, comComment, Datecom;
  final double rate;
  final Map<String, dynamic> item;

  @override
  _UserReviewCardState createState() => _UserReviewCardState();
}
class _UserReviewCardState extends State<UserReviweCard> {

  Future<void> deleteratings(String UserName, String Name) async {
    try {
      var response = await http.delete(
        Uri.parse('https://gp-back-gp.onrender.com/Rating/DElete/Store-reviw'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "UserName": UserName,
          "Name": Name,
        }),
      );
      if (response.statusCode == 200) {
        print('done');
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during API request: $e');
    }
  }
 bool yesSelected = false;
  bool noSelected = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (username ==widget.userName)
              PopupMenuButton(
                child: const Icon(Icons.more_vert),
                onSelected: (value) {
                  if (value == "تعديل") {
                    showeditRatingDialog(context,widget. userName,
                        "assets/images/userprofile.png",widget. rate, comment,widget. item);
                  } else if (value == "حذف") {
    
                    deleteratings(widget. userName,widget.StoreName);
                    showCards(context, "assets/thankyou.json", 'تم الحذف');
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                  const PopupMenuItem(
                    value: "تعديل",
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Icon(Icons.edit),
                        ),
                        Text(
                          'تعديل',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: "حذف",
                    child: Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Icon(Icons.delete)),
                        Text(
                          'حذف',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            Spacer(),
            Row(
              children: [
                Text(
                 widget. userName,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  width: 10,
                ),
                const CircleAvatar(
                  backgroundImage: AssetImage("assets/images/userprofile.png"),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
             widget.Date,
              style: Theme.of(context).textTheme.bodyMedium,
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(
              width: 10,
            ),
            Ratingbar(
              rate:widget. rate,
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.topRight,
          child: ReadMoreText(
            comment,
            trimLines: 2,
            textDirection: TextDirection.rtl,
            trimMode: TrimMode.Line,
            trimExpandedText: "عرض أقل",
            trimCollapsedText: "عرض المزيد",
            lessStyle: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue),
            moreStyle: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
       Directionality
       (
        textDirection: TextDirection.rtl,
         child: Row(
          children: [
            const Text("هل وجدت هذا مفيدا؟",style: TextStyle(fontSize: 15),),
            const SizedBox(width: 10), 
            ElevatedButton(
               style: ElevatedButton.styleFrom(
        minimumSize: const Size(30, 20),
        backgroundColor: yesSelected ? Colors.green : null,
        ),
              onPressed: () {
              setState(() {
              yesSelected = true;
              noSelected = false;
            });              },
              child: const Text("نعم",style: TextStyle(color: Colors.black)),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
              setState(() {
              yesSelected = false;
              noSelected = true;
            });              },
                style: ElevatedButton.styleFrom(
        minimumSize: const Size(30, 20),
        backgroundColor: noSelected ? Colors.green : null,
      ),
              child: const Text("لا",style: TextStyle(color: Colors.black),),
            ),
          ],
               ),
       ),
      const SizedBox(height: 6,),
      if(widget.comComment.isNotEmpty)
        Container(
          decoration: const BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                    widget.Datecom,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textDirection: TextDirection.rtl,
                    ),
                    Text(
                     widget. StoreName,
                      style: Theme.of(context).textTheme.titleLarge,
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                 Align(
                  alignment: Alignment.topRight,
                  child: ReadMoreText(
                   widget. comComment,
                    trimLines: 2,
                    textDirection: TextDirection.rtl,
                    trimMode: TrimMode.Line,
                    trimExpandedText: "عرض أقل",
                    trimCollapsedText: "عرض المزيد",
                    lessStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                    moreStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
