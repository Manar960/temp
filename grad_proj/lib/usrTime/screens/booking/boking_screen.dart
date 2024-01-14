import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../butombar.dart';
import '../../../config.dart';
import '../../../login/responsive.dart';

import '../../map/map.dart';
import '../../models/user.dart';
import '../cart/cart_screen.dart';
import '../home/home_screen.dart';
import 'body.dart';

// ignore: camel_case_types
class bookScreen extends StatefulWidget {
  const bookScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _bookScreenState createState() => _bookScreenState();
}

String? username = AuthProvider.userData?.userName;

// ignore: camel_case_types
class _bookScreenState extends State<bookScreen> {
  List? item;
  Future<void> getBookingsForUser(String userName) async {
    try {
      var response = await http.get(
        Uri.parse('https://gp-back-gp.onrender.com/bookings-for/user/$userName'),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        setState(() {
          item = jsonResponse['bookings'];
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during API request: $e');
    }
  }

  @override
  void initState() {
    super.initState();
     getBookingsForUser(username!);
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        title: const Text('الحجوزات'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Directionality(
              textDirection: TextDirection.rtl,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: Responsive.isDesktop(context) ? 2 : 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 20,
                    childAspectRatio: Responsive.isDesktop(context) ? 3.5 : 2.5),
                itemCount: item?.length ?? 0,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Body(
                    storeName: item![index]['CombanyName'],
                    stroeImage: item![index]['Comimage'],
                    date: DateTime.parse(item![index]['date']),
                    bookingcode: item![index]['BookingCode'],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return const HomeScreenu();
                }),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return const bookScreen();
                }),
              );
              break;
            case 2:
              // MapPage
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return const MapPage();
                }),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return const CartScreen();
                }),
              );
              break;
            case 4:
              // Navigate to the personal page
              break;
          }
        },
      ),
    );
  }
}
