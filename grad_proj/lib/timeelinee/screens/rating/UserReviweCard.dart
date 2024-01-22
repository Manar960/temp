import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grad_proj/constants.dart';
import '../../../dialog.dart';
import 'edit.dart';
import 'rate.dart';
import 'package:http/http.dart' as http;
import 'package:readmore/readmore.dart';

class UserReviweCard extends StatelessWidget{
  const UserReviweCard({Key?key, required this.userName, required this.Date, required this.comment, required this.rate, required this.comName, required this.comComment, required this.Datecom}):super(key: key);
final String userName,Date,comment;
final double rate;
final String comName,comComment,Datecom;


Future<void> deleteratings(String UserName,String Name ) async {
    try {
     
      var response = await http.delete(
        Uri.parse('https://gp-back-gp.onrender.com/Rating/DElete/Store-reviw'),
        headers: {"Content-Type": "application/json"},
          body: jsonEncode({
        "UserName":UserName,
        "Name":Name,
    
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
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Spacer(),
            Row(
              children: [
              Text(userName,style: Theme.of(context).textTheme.titleLarge,),
              const SizedBox(width: 10,),
              const CircleAvatar(backgroundImage: AssetImage("assets/images/userprofile.png"),),
              ],
            ),
            
          ],
        ),
        const SizedBox(height: 10,),
        Row(
           mainAxisAlignment: MainAxisAlignment.end,
        children: [
         Text(Date,style: Theme.of(context).textTheme.bodyMedium,textDirection: TextDirection.rtl,),
         const SizedBox(width: 10,),
        Ratingbar(rate: rate,),
        ],
        ),
        const SizedBox(height: 10,),
         Align(
          alignment: Alignment.topRight,
          child: ReadMoreText(
              comment,
              trimLines: 2,
              textDirection: TextDirection.rtl,
              trimMode: TrimMode.Line,
              trimExpandedText: "عرض أقل",
              trimCollapsedText:"عرض المزيد" ,
              lessStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.blue),
              moreStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.blue),
              
          ),

        ),
        const SizedBox(height: 20,),
         Row(
          children: [
             const Spacer(),
             InkWell(
              onTap: () {  
                  deleteratings(userName, comName);
                  showCards(context, "assets/thankyou.json", 'تم الحذف');
              },
               child: const Column(
                 children: [
                   Icon(Icons.delete),
                   Text("حذف")
                 ],
               ),
             ),
            const SizedBox(width: 20,),
             InkWell(
              onTap: () {
                  showeditRatingDialog1(context, userName,comName);
              },
               child: const Column(
                 children: [
                  Icon(Icons.comment),
                  Text("رد")
                 ],
               ),
             ),
          ],
        ),
      if(comComment.isNotEmpty)
       const SizedBox(height: 15,),
       Container(
          decoration: const BoxDecoration(
            color: kPrimaryColor, 
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15)
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Datecom,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textDirection: TextDirection.rtl,
                    ),
                    Text(
                      comName,
                      style: Theme.of(context).textTheme.titleLarge,
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                 Align(
                  alignment: Alignment.topRight,
                  child: ReadMoreText(
                    comComment,
                    trimLines: 2,
                    textDirection: TextDirection.rtl,
                    trimMode: TrimMode.Line,
                    trimExpandedText: "عرض أقل",
                    trimCollapsedText: "عرض المزيد",
                    lessStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue),
                    moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue),
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