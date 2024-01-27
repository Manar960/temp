import 'package:flutter/material.dart';
import '../../../butombar.dart';
import '../../map/map.dart';
import '../../profile/page/profile_page_user.dart';
import '../booking/boking_screen.dart';
import '../cart/cart_screen.dart';
import '../home/components/home_header.dart';
import '../home/home_screen.dart';
import 'caracc1.dart';
import 'carseting.dart';
import 'carshowrooms.dart';

class StoresScreen extends StatelessWidget {
  const StoresScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SingleChildScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15),
            HomeHeader(),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Divider(
                height: 4,
              ),
            ),
            SizedBox(height: 20),
            caracc(),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Divider(
                height: 4,
              ),
            ),
            SizedBox(height: 20),
            carseting(),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Divider(
                height: 4,
              ),
            ),
            SizedBox(height: 20),
            carshowrooms(),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Divider(
                height: 4,
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
