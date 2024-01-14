import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grad_proj/constants.dart';
import '../../../home/components/section_title.dart';
import '../../detailpage/Detailpage.dart';
import '../../store2/store2.dart';
import 'product_card.dart';
import 'package:http/http.dart' as http;

import 'seeall.dart';

class NewArrivalProducts extends StatefulWidget {
  const NewArrivalProducts({Key? key, required this.item}) : super(key: key);
  final Map<String, dynamic> item;

  @override
  // ignore: library_private_types_in_public_api
  _NewArrivalProductsState createState() => _NewArrivalProductsState();
}

class _NewArrivalProductsState extends State<NewArrivalProducts> {
  List? item;

  @override
  void initState() {
    super.initState();
    getnewProducts();
  }

  Future<void> getnewProducts() async {
    try {
      var response = await http.get(
        Uri.parse('https://gp-back-gp.onrender.com/get-new-pro/${widget.item['Name']}'),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        setState(() {
          item = jsonResponse['data'];
        });
      } else {
        // ignore: avoid_print
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error during API request: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: title(tile: "الجديد",icon: Icons.new_releases),

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
                  title: item![index]["Name"],
                  image: item![index]["proimage"],
                  price: item![index]["price"],
                  bgColor: index % 2 == 0
                      ? bluebasic
                      : const Color(0xFFF8FEFB),
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Detailsproduct(item: item![index]),
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
