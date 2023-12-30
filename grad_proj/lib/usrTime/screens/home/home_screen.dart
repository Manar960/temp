import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../map/map.dart';
import '../../curved_navigation_bar.dart';
import 'components/categories.dart';
import 'components/discount_banner.dart';
import 'components/home_header.dart';
import 'components/popular_product.dart';
import 'components/special_offers.dart';
import '../../../userPro/page/profile_page.dart';

class HomeScreencomu extends StatefulWidget {
  const HomeScreencomu({Key? key}) : super(key: key);

  @override
  _HomeScreencomuState createState() => _HomeScreencomuState();
}

class _HomeScreencomuState extends State<HomeScreencomu> {
  // Declare SharedPreferences variable
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    // Initialize SharedPreferences
    initPrefs();
  }

// Function to initialize SharedPreferences
  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
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
                    return const HomeScreencomu();
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
                    return MapScreen();
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
                // Navigate to the personal page ProfilePage
                String? token = prefs.getString('token');
                String? email = prefs.getString('email');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return ProfilePage(
                      token: token,
                      userName: email,
                    );
                  }),
                );
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
                          return const HomeScreencomu();
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
                          return MapScreen();
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
                      // Navigate to the personal page ProfilePage
                      String? token = prefs.getString('token');
                      String? email = prefs.getString('email');
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return ProfilePage(
                            token: token,
                            userName: email,
                          );
                        }),
                      );
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

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          // Mobile UI
          return buildMobileUI(context);
        } else if (constraints.maxWidth < 1200) {
          // Tablet UI
          return buildTabletUI(context);
        } else {
          // Desktop UI
          return buildDesktopUI(context);
        }
      },
    );
  }
}
