import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../../../../../config.dart';
import '../../../../../login/responsive.dart';
import '../../detailpage/Detailpage.dart';
import 'product_card.dart';

class SeeAll extends StatefulWidget {
  const SeeAll({Key? key, required this.item}) : super(key: key);
  final Map<String, dynamic> item;

  @override
  _SeeAllState createState() => _SeeAllState();
}

class _SeeAllState extends State<SeeAll> {
  List? item;

  @override
  void initState() {
    super.initState();
    getProducts(widget.item['_id']);
  }

  Future<void> getProducts(String storeId) async {
    var response = await http.get(
      Uri.parse('$showcars/$storeId/Car'),
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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              " السيارات",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: Responsive.isDesktop(context) ? 3 : 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: Responsive.isDesktop(context) ? 1 : 0.5,
                ),
                itemCount: item?.length ?? 0,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ProductCard(
                    title: item![index]['Name'],
                    image: item![index]['proimage'],
                    price: item![index]['price'],
                    bgColor: index % 2 == 0
                        ? Color.fromARGB(255, 248, 107, 68)
                        : Color.fromARGB(255, 237, 222, 167),
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => store1(item: item![index]),
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
