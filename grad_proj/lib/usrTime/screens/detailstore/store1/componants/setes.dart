import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../components/product_card.dart';
import '../../../home/components/section_title.dart';
import '../../detailpage/Detailpage.dart';

class setes extends StatefulWidget {
  const setes({
    Key? key,
  }) : super(key: key);

  @override
  _setesState createState() => _setesState();
}

class _setesState extends State<setes> {
  List? item;
  late bool isnew;
  @override
  void initState() {
    super.initState();
    getNewArrivalProducts();
  }

  Future<void> getNewArrivalProducts() async {
    try {
      var response = await http.get(
        Uri.parse(
            'https://gp-back-gp.onrender.com/products/getpro/halacar/seting'),
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
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: SectionTitle(
            title: "مقاعد",
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
