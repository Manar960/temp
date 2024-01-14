import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:grad_proj/login/responsive.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'UserReviweCard.dart';

class Ratingbar1 extends StatefulWidget {
  const Ratingbar1({Key? key, required this.item}) : super(key: key);
  final Map<String, dynamic> item;

  @override
  _RatingbarState createState() => _RatingbarState();
}

class _RatingbarState extends State<Ratingbar1> {
  List? item;

 

  Future<void> getAllratings() async {
    try {
      String name = widget.item['Name'];
      var response = await http.get(
        Uri.parse('https://gp-back-gp.onrender.com/Rating/All-Rates/Store/$name'),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        setState(() {
          item = jsonResponse['ratings'];
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during API request: $e');
    }
  }

  Future<void> _refresh() async {
    await getAllratings();
  }
 
  @override
  Widget build(BuildContext context) {
      getAllratings();
    return RefreshIndicator(
      onRefresh: _refresh,
      child: Column(
        children: [
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: Responsive.isDesktop(context) ? 5 : 1.5,
            ),
            itemCount: item?.length ?? 0,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              String dateString = item![index]['updatedAt'];
              DateTime date = DateTime.parse(dateString);
              return UserReviweCard(
                userName: item![index]['UserName'],
                comment: item![index]['Comments'],
                rate: item![index]['Rateing'],
                Date: DateFormat('yyyy-MM-dd').format(date).toString(),
                StoreName: widget.item['Name'],
                item: widget.item,
              );
            },
          ),
        ],
      ),
    );
  }
}
