import 'package:flutter/material.dart';
import '../../../login/responsive.dart';
import '../../../usrTime/screens/home/components/home_header.dart';
import '../../curved_navigation_bar.dart';
import '../forms/formscom.dart';
import '../stoks/stock.dart';
import 'bodyhome.dart';
import 'calendar/calendar.dart';
import 'components/discount_banner.dart';

class HomeScreencom extends StatelessWidget {
  static String routeName = "/home";

  const HomeScreencom({Key? key}) : super(key: key);

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
              SizedBox(height: 90),
              ComponantBody(),
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
            Icon(Icons.factory, size: 30, color: Colors.white),
            Icon(Icons.person, size: 30, color: Colors.white),
          ],
          onTap: (index) {
            switch (index) {
              case 0:
                Navigator.pushNamed(context, HomeScreencom.routeName);
                break;

              case 1:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return CalendarPage(
                      title: 'calendar',
                    );
                  }),
                );
                break;
              case 2:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return MyButtonsScreen();
                  }),
                );
                break;
              case 3:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return StokScreenPage();
                  }),
                );

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
                    SizedBox(height: 90),
                    ComponantBody(),
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
                  Icon(Icons.add, size: 30, color: Colors.white),
                  Icon(Icons.factory, size: 30, color: Colors.white),
                  Icon(Icons.person, size: 30, color: Colors.white),
                ],
                onTap: (index) {
                  switch (index) {
                    case 0:
                      Navigator.pushNamed(context, HomeScreencom.routeName);
                      break;
                    case 1:
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return CalendarPage(
                            title: 'calendar',
                          );
                        }),
                      );
                      break;
                    case 2:
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return MyButtonsScreen();
                        }),
                      );
                      break;
                    case 3:
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return StokScreenPage();
                        }),
                      );
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
