import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../components/product_card.dart';
import '../../../home/components/section_title.dart';
import '../../detailpage/Detailpage.dart';

class Wheel extends StatefulWidget {
  const Wheel({Key? key, required this.item}) : super(key: key);
  final Map<String, dynamic> item;
  @override
  _WheelState createState() => _WheelState();
}

class _WheelState extends State<Wheel> {
  List? item;
  @override
  void initState() {
    super.initState();
    fetchWheelProductsForStore(widget.item['_id']);
  }

  Future<void> fetchWheelProductsForStore(String storeId) async {
    var response = await http.get(
      Uri.parse('https://gp-back-gp.onrender.com/$storeId/Wheels'),
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
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: SectionTitle(
            title: "عجلات",
            press: () {},
            showSeeAllButton: false,
          ),
        ),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              item!.length,
              (index) => Padding(
                padding: const EdgeInsets.only(right: 16),
                child: ProductCard(
                  title: item![index]['Name'],
                  image: item![index]['proimage'],
                  price: item![index]['price'],
                  bgColor: Color.fromARGB(255, 246, 163, 108),
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => store1(item: item![index]),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
