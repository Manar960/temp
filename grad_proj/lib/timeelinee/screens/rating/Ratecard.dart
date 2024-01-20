
import 'dart:convert';
import 'package:grad_proj/constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Ratecard extends StatefulWidget {
  const Ratecard({
    Key? key,
    required this.press, required this.item,

  }) : super(key: key);

  final VoidCallback press;
final Map<String, dynamic> item;


  @override
  _RatecardState createState() => _RatecardState();
}

class _RatecardState extends State<Ratecard> {
  bool isHover = false;
late int number=0;
  Future<void> getnumber(String storeName) async {
  try {
    var response = await http.get(
      Uri.parse('https://gp-back-gp.onrender.com/Rating/length/Store-/$storeName'),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      setState(() {
        number = jsonResponse['totalRatings'];
      });
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  } catch (e) {
    print('Error during API request: $e');
  }
}
 @override
  void initState() {
    super.initState();
    getnumber(widget.item['Name']);

  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.press,
      onHover: (value) {
        setState(() {
          isHover = value;
         
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          color: bluebasic,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [if (isHover) kDefaultCardShadow],
        ),
        child: Stack(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "التقييمات والمراجعات",
                              style: TextStyle(color: white,fontSize: 20),
                                  
                            ),
                            SizedBox(width: 10,),
                            Text(
                              "($number)",
                              style: TextStyle(color: white,fontSize: 20),
                                  
                            ),
                            const Spacer(),
                            const Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,size: 16,)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
