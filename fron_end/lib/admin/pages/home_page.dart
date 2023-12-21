import 'package:flutter/material.dart';
import '../../timeelinee/curved_navigation_bar.dart';
import '/admin/controllers/menu_controller.dart' as MyMenuController;
import 'package:provider/provider.dart';

import '../applecation/applection.dart';
import '../comment/comm.dart';

import '../profile/page/profile_page.dart';
import '../reports/report.dart';
import 'dashboard/dashboard.dart';

class HomePageadmin extends StatefulWidget {
  final String adminEmail;

  const HomePageadmin({
    Key? key,
    required this.adminEmail,
  }) : super(key: key);

  @override
  State<HomePageadmin> createState() => _HomePageadminState();
}

class _HomePageadminState extends State<HomePageadmin> {
  String currentPage = "Dashboard";

  void changePage(String page) {
    setState(() {
      currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyMenuController.MenuController(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(),
              ),
              Expanded(
                flex: 9,
                child: currentPage == "Dashboard"
                    ? Dashboard(
                        adminEmail:
                            widget.adminEmail) // تمرير البريد الإلكتروني هنا
                    : currentPage == "Profile"
                        ? ProfilePagead(
                            adminEmail: widget.adminEmail,
                          )
                        : currentPage == "Application"
                            ? ApplicationList()
                            : currentPage == "Reports"
                                ? ReportPage()
                                : currentPage == "Comment"
                                    ? CommentPage()
                                    : Dashboard(
                                        adminEmail:
                                            widget.adminEmail), // وهنا أيضا
              ),
            ],
          ),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          items: const [
            Icon(Icons.home),
            Icon(Icons.business),
            Icon(Icons.comment),
            Icon(Icons.bar_chart),
            Icon(Icons.people),
          ],
          index: 0,
          onTap: (index) {
            switch (index) {
              case 0:
                changePage("Dashboard");
                break;
              case 1:
                changePage("Application");
                break;
              case 2:
                changePage("Comment");
                break;
              case 3:
                changePage("Reports");
                break;
              case 4:
                changePage("Profile");
                break;
            }
          },
        ),
      ),
    );
  }
}
