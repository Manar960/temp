import 'package:flutter/material.dart';

import 'usrTime/curved_navigation_bar.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF063970),
      child: CurvedNavigationBar(
        index: currentIndex,
        color: Color(0xFF063970),
        buttonBackgroundColor: Color(0xFF063970),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        height: 75.0,
        items: const [
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.book, size: 30, color: Colors.white),
          Icon(Icons.map, size: 30, color: Colors.white),
          Icon(Icons.favorite, size: 30, color: Colors.white),
          Icon(Icons.shopping_cart, size: 30, color: Colors.white),
          Icon(Icons.person, size: 30, color: Colors.white),
        ],
        onTap: onTap,
      ),
    );
  }
}
