import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../../../login/responsive.dart';
import '../../../home/components/section_title.dart';
import 'Subcat.dart';
import 'catcard.dart';
class Categoriesviwe extends StatefulWidget {
  const Categoriesviwe({
    Key? key, required this.item,
  }) : super(key: key);
final Map<String, dynamic> item;

  @override
  _CategoriesviweState createState() => _CategoriesviweState();
}
 
class _CategoriesviweState extends State<Categoriesviwe> {
  List? item;
  late bool isnew;
  @override
  void initState() {
    super.initState();
   fetchWheelProductsForStore(widget.item["Name"]);
  }

Future<void> fetchWheelProductsForStore(String name) async {
    var response = await http.get(
      Uri.parse('http://localhost:4000/pro/cat/$name'),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      setState(() {
        item = jsonResponse['Category1'];
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
            title: "الاقسام",
            press: () {},
            showSeeAllButton: false,
          ),
        ),
           Padding(
             padding: const EdgeInsets.all(30),
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
                        builder: (context) => Subcat(item: item![index]['subcategories']),
                      ),
                    );
                    },
                  );
                       },
                     ),
           ),
      ],
    );
  }
}