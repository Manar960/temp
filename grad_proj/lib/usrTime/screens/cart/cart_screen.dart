import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:http/http.dart' as http;
import '../../../butombar.dart';
import '../../../config.dart';
import '../../map/map.dart';
import '../booking/boking_screen.dart';
import '../../curved_navigation_bar.dart';
import '../../profile/page/profile_page_user.dart';
import '../home/home_screen.dart';
import 'components/cart_card.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatefulWidget {
  static String routeName = "/cart";

  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List? item = [];
  @override
  void initState() {
    super.initState();
  }

  Future<void> getallitemcarts() async {
    try {
      var response = await http.get(
        Uri.parse('https://gp-back-gp.onrender.com/getallitemcarts/$username'),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        setState(() {
          item = jsonResponse['cartItems'];
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during API request: $e');
    }
  }

  Future<void> removeFromCart(String proBarCode, String userName) async {
    final url = 'https://gp-back-gp.onrender.com/cart/removeallCart';

    final response = await http.delete(
      Uri.parse(deleteCart),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'ProBarCode': proBarCode,
        'UserName': userName,
      }),
    );
    if (response.statusCode == 200) {
      print('Product deleted to cart successfully');
    } else {
      print('Failed to deleted product to cart');
    }
  }

  @override
  Widget build(BuildContext context) {
    getallitemcarts();

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                  itemCount: item!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Dismissible(
                        key: Key(
                            '${item![index]['ProBarCode']}_${index.toString()}'),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          setState(() {
                            removeFromCart(
                                item![index]['ProBarCode'].toString(),
                                username!);
                          });
                        },
                        background: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFE6E6),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              const Spacer(),
                              SvgPicture.asset("assets/icon/trash.svg"),
                            ],
                          ),
                        ),
                        child: CartCard(cart: item![index]),
                      ),
                    );
                  }),
            ),
          ),
          const CheckoutCard(),
        ],
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
                  return MapPage();
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return const ProfilePage();
                }),
              );
              break;
          }
        },
      ),
    );
  }
}
