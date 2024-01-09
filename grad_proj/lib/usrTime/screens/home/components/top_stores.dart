import 'package:flutter/material.dart';
import '../../stores/store_screen.dart';
import 'store_card.dart';
import 'section_title.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class topstore extends StatefulWidget {
  const topstore({Key? key}) : super(key: key);

  @override
  _topstoreState createState() => _topstoreState();
}

class _topstoreState extends State<topstore> {
  List? item;

  @override
  void initState() {
    super.initState();
    getstoreProducts();
  }

  Future<void> getstoreProducts() async {
    try {
      var response = await http.get(
        Uri.parse('https://gp-back-gp.onrender.com/gettopcompany'),
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
            title: "افضل المحلات",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return const StoresScreen();
                }
                ),
              );
            },
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              if (item != null)
                ...List.generate(
                  item!.length,
                  (index) {
                     return Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Store(
                        title:item![index]['Name'].toString(), 
                        image: item![index]['comimag'],
                        onPress: (){},
                        rating: item![index]['rate'],
                      ),
                      
                    );
                    
                  },
                ),
              const SizedBox(width: 20),
            ],
          ),
        ),
      ],
    );
  }
}
