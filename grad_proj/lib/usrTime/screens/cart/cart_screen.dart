import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:http/http.dart' as http;
import '../../../config.dart';

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
  List? item;
  @override
  void initState() {
    super.initState();
  }

  Future<void> getallitemcarts() async {
    try {
      var response = await http.get(
        Uri.parse(cartItem),
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
    final url = 'http://localhost:4000/cart/removeallCart';

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
                                item![index]['ProBarCode'], username!);
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
          CheckoutCard(),
        ],
      ),
      bottomNavigationBar: Container(
        color: const Color(0xFF063970),
        child: CurvedNavigationBar(
          index: 3,
          color: const Color(0xFF063970),
          buttonBackgroundColor: const Color(0xFF063970),
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          height: 75.0,
          items: const [
            Icon(Icons.home, size: 30, color: Colors.white),
            Icon(Icons.book, size: 30, color: Colors.white),
            Icon(Icons.map, size: 30, color: Colors.white),
            Icon(Icons.shopping_cart, size: 30, color: Colors.white),
            Icon(Icons.person, size: 30, color: Colors.white),
          ],
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
                // Handle book button tap
                break;
              case 2:
                // Handle add button tap
                break;
              case 3:
                // Handle factory button tap
                break;
              case 4:
                // ProfilePage
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
      ),
    );
  }
}
