import 'package:flutter/material.dart';
import 'package:grad_proj/login/responsive.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../butombar.dart';
import '../../../constants.dart';
import '../../map/map.dart';
import '../booking/boking_screen.dart';
import '../cart/cart_screen.dart';
import '../home/home_screen.dart';
import 'cards.dart';

// ignore: camel_case_types
class favScreen extends StatefulWidget {
  const favScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _favScreenState createState() => _favScreenState();
}

// ignore: camel_case_types
class _favScreenState extends State<favScreen> {
  List? item;
  Future<void> getfav() async {
    try {
      var response = await http.get(
        Uri.parse('https://gp-back-gp.onrender.com/Fav'),
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
  void initState() {
    super.initState();
       
  }

  @override
  Widget build(BuildContext context) {
 getfav();
    return Scaffold(
      appBar: AppBar(
        title: const Text('المفضلة'),
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
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: Responsive.isDesktop(context) ? 4 : 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 20,
                  childAspectRatio: Responsive.isDesktop(context) ? 1.5 : 1),
              itemCount: item?.length ?? 0,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return FavCard(
                  title: item![index]['ProName'],
                  image: item![index]['Proimage'],
                  bgColor: bluebasic,
                  isActive: true,
                );
              },
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
