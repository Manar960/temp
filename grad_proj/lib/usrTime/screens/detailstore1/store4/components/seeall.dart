import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:grad_proj/constants.dart';
import 'package:grad_proj/login/responsive.dart';
import 'package:http/http.dart' as http;
import '../../detailpage/Detailpage.dart';
import 'product_card.dart';

class SeeAll extends StatefulWidget {
  const SeeAll({Key? key, required this.item}) : super(key: key);
  final Map<String, dynamic> item;

  @override
  // ignore: library_private_types_in_public_api
  _SeeAllState createState() => _SeeAllState();
}

class _SeeAllState extends State<SeeAll> {
  List? item;

  @override
  void initState() {
    super.initState();
    getProducts(widget.item['Name']);
  }

  Future<void> getProducts(String Name) async {
    var response = await http.get(
      Uri.parse('http://localhost:4000/getpro/$Name/Car'),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              " السيارات",
              style: Theme.of(context).textTheme.bodyLarge,
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
              Directionality(
                textDirection: TextDirection.rtl,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: Responsive.isDesktop(context) ? 3 : 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: Responsive.isDesktop(context) ? 1 : 0.5,
                  ),
                  itemCount: item?.length ?? 0,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ProductCard(
                      title: item![index]['Name'],
                      image: item![index]['proimage'],
                      price: item![index]['price'],
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
                    );
                  },
                ),
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
