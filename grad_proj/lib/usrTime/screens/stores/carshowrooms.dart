import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../login/responsive.dart';
import '../detailstore1/store4/homescreen.dart';
import '../home/components/section_title.dart';
import 'storecards.dart';

// ignore: camel_case_types
class carshowrooms extends StatefulWidget {
  const carshowrooms({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _carshowroomsState createState() => _carshowroomsState();
}

// ignore: camel_case_types
class _carshowroomsState extends State<carshowrooms> {
  List? item;

  @override
  void initState() {
    super.initState();
    getstore();
  }

  Future<void> getstore() async {
    try {
      var response = await http.get(
        Uri.parse(
            'https://gp-back-gp.onrender.com/getsametypecompany/Car%20showrooms'),
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionTitle(
            title: "معارض السيارات",
            press: () {},
            showSeeAllButton: false,
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        Directionality(
          textDirection: TextDirection.rtl,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: Responsive.isDesktop(context) ? 3 : 1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 20,
              childAspectRatio: 3,
            ),
            itemCount: item?.length ?? 0,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Storse(
                title: item![index]['Name'].toString(),
                image: item![index]['comimag'],
                location: item![index]['location'].toString(),
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => store4(item: item![index]),
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
