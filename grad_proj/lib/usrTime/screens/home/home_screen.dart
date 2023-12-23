import 'package:flutter/material.dart';
import '../../../login/responsive.dart';
//import '../../../timeelinee/screens/cart/cart_screen.dart';
import '../../curved_navigation_bar.dart';
import '../../map/map.dart';
import 'components/categories.dart';
import 'components/discount_banner.dart';
import 'components/home_header.dart';
import 'components/popular_product.dart';
import 'components/special_offers.dart';

class HomeScreenu extends StatelessWidget {
  static String routeName = "/home";

  const HomeScreenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: buildMobileUI(context),
      tablet: buildTabletUI(context),
      desktop: buildDesktopUI(context),
    );
  }

  Widget buildMobileUI(BuildContext context) {
    return Scaffold(
      body: const SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              HomeHeader(),
              DiscountBanner(),
              Categories(),
              SpecialOffers(),
              SizedBox(height: 20),
              PopularProducts(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: const Color(0xFF063970),
        child: CurvedNavigationBar(
          index: 0,
          color: const Color(0xFF063970),
          buttonBackgroundColor: const Color(0xFF063970),
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          height: 75.0,
          items: const [
            Icon(Icons.home, size: 30, color: Colors.white),
            Icon(Icons.book, size: 30, color: Colors.white),
            Icon(Icons.add, size: 30, color: Colors.white),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const NearbyPage();
                  }),
                );
                break;
              case 3:
                /*Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    //return const CartScreen();
                  }),
                );*/
                break;
              case 4:
                // Navigate to the personal page
                break;
            }
          },
        ),
      ),
    );
  }

  Widget buildTabletUI(BuildContext context) {
    return buildMobileUI(context);
  }

  Widget buildDesktopUI(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  children: [
                    HomeHeader(),
                    DiscountBanner(),
                    Categories(),
                    SpecialOffers(),
                    SizedBox(height: 20),
                    PopularProducts(),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            Container(
              color: const Color(0xFF063970),
              child: CurvedNavigationBar(
                index: 0,
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
                      // Navigate to the report page
                      break;
                    case 2:
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return const NearbyPage();
                        }),
                      );
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
            ),
          ],
        ),
      ),
    );
  }
}
