import 'package:flutter/material.dart';
import '../../../login/responsive.dart';
import '../../curved_navigation_bar.dart';
import '../../map/map.dart';
import '../../profile/page/profile_page_user.dart';
import '../booking/boking_screen.dart';
import '../cart/cart_screen.dart';
import 'components/banner.dart';
import 'components/categories.dart';
import 'components/discount_banner.dart';
import 'components/home_header.dart';
import 'components/top_stores.dart';

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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              const HomeHeader(),
              const DiscountBanner(),
              const Categories(),
              const SizedBox(height: 20),
              Responsive.isDesktop(context)
                  ? const BannerSection()
                  : const MobBanner(), 
              const SizedBox(height: 20),
              const topstore(),
              const SizedBox(height: 20),
              const SizedBox(height: 20),
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
            Icon(Icons.map_outlined, size: 30, color: Colors.white),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const bookScreen();
                  }),
                );
                break;
              case 2:
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
              //
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
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  children: [
                    const HomeHeader(),
                    const DiscountBanner(),
                    const Categories(),
                    Responsive.isDesktop(context)
                        ? const BannerSection()
                        : const MobBanner(),
                    const topstore(),
                    const SizedBox(height: 20),
                    //PopularProducts(),
                    const SizedBox(height: 20),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return const bookScreen();
                        }),
                      );
                      break;
                    case 2:
                      //MapPaje
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
            ),
          ],
        ),
      ),
    );
  }
}
