import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../../../login/responsive.dart';
import '../../../home/components/section_title.dart';
import '../../detailpage/Detailpage.dart';
import 'Subcat.dart';
import 'catcard.dart';
class Brandviwe extends StatefulWidget {
  const Brandviwe({
    Key? key, required this.item,
  }) : super(key: key);
final Map<String, dynamic> item;

  @override
  _BrandviweState createState() => _BrandviweState();
}
 
class _BrandviweState extends State<Brandviwe> {
  List? item;
  late bool isnew;
  @override
  void initState() {
    super.initState();
   fetchProductsForStore(widget.item["Name"]);
  }

Future<void> fetchProductsForStore(String name) async {
    var response = await http.get(
      Uri.parse('http://localhost:4000/brand-product/cat/$name/brand'),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      setState(() {
        item = jsonResponse['Brand1'];
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
          padding: const EdgeInsets.all(16),
          child: SectionTitle(
            title: "العلامات التجارية",
            press: () {},
            showSeeAllButton: false,
          ),
        ),
           Padding(
             padding: const EdgeInsets.all(30),
             child: Directionality(
              textDirection: TextDirection.rtl,
               child: GridView.builder(
                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: Responsive.isDesktop(context)?3:2, 
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: Responsive.isDesktop(context)?2:1, 
                         ),
                         itemCount: item?.length ?? 0,
                         shrinkWrap: true,
                         physics: const NeverScrollableScrollPhysics(),
                         itemBuilder: (context, index) {
                       return  CatCard(
                      name: item![index]['categoryName'],
                      image: item![index]['categoryImage'],
                      press: () {
                              Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Productsub(item: item![index]['products']),
                        ),
                      );
                      },
                    );
                         },
                       ),
             ),
           ),
      ],
    );
  }
}