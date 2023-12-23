import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../timeelinee/curved_navigation_bar.dart';

import '../../home/home_screen.dart';
import 'chat_page.dart';

class MainPagemsg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChatPage(),
      bottomNavigationBar: CurvedNavigationBar(
        index: 0,
        color: Color(0xFF063970),
        buttonBackgroundColor: Color(0xFF063970),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
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
              // Navigate to the report page
              break;
            case 2:
              break;
            case 3:
              /* Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return const CartScreen();
                }),
              );*/
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
