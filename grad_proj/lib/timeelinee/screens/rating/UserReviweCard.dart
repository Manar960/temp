import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grad_proj/constants.dart';
import '../../../dialog.dart';
import 'edit.dart';
import 'rate.dart';
import 'package:http/http.dart' as http;
import 'package:readmore/readmore.dart';

class UserReviweCard extends StatelessWidget{
  const UserReviweCard({Key?key, required this.userName, required this.Date, required this.comment, required this.rate, required this.StoreName}):super(key: key);
final String userName,Date,comment;
final double rate;
final String StoreName;


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
            PopupMenuButton(
            child: const Icon(Icons.more_vert), 
          
            onSelected: (value) {
             
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
                      child: Icon(Icons.delete)
                    ),
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
                      "1/1/2024",
                      style: Theme.of(context).textTheme.bodyMedium,
                      textDirection: TextDirection.rtl,
                    ),
                    Text(
                      "هلا كار",
                      style: Theme.of(context).textTheme.titleLarge,
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Align(
                  alignment: Alignment.topRight,
                  child: ReadMoreText(
                    "...مرحبا المتجر كثير ممتاز وتعاملهم رائع وبضاعتهم اروع انصحكم تشتروا منه اخلاق اسم الله استمروا فايتنج اايببل لايب يلا يبا بيغ غايابلا يغت سغات يغت يلبات سيت فالقيللر بلايبغغ ا ",
                    trimLines: 2,
                    textDirection: TextDirection.rtl,
                    trimMode: TrimMode.Line,
                    trimExpandedText: "عرض أقل",
                    trimCollapsedText: "عرض المزيد",
                    lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue),
                    moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue),
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