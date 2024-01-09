import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../login/responsive.dart';
import '../home/components/section_title.dart';
import 'storecards.dart';


class carcolors extends StatefulWidget {
  const carcolors({Key? key}) : super(key: key);

  @override
  _carcolorsState createState() => _carcolorsState();
}

class _carcolorsState extends State<carcolors> {
  List? item;

  @override
  void initState() {
    super.initState();
    getstore();
  }

  Future<void> getstore() async {
    try {
      var response = await http.get(
        Uri.parse('https://gp-back-gp.onrender.com/getsametypecompany/Car%20color'),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        setState(() {
          item = jsonResponse['data'];

        });
         
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionTitle(
            title: "دهان السيارات",
            press: () {
            },
            showSeeAllButton: false,
            
          ),
        ),
            SizedBox(height: 25,),
         Directionality(
           textDirection: TextDirection.rtl,
           child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: Responsive.isDesktop(context)?3:1, 
              crossAxisSpacing: 10,
              mainAxisSpacing: 20,
              childAspectRatio: 3, 
            ),
            itemCount: item?.length ?? 0,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              var product = item![index];
              return Storse(
                title: item![index]['Name'].toString(),
                image: item![index]['comimag'],
                location: item![index]['location'].toString(),
                press: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => store1(item: item![index]),
                  //   ),
                  // );
                },
              );
            },
                   ),
         ),
      ],
    );
  }
}
