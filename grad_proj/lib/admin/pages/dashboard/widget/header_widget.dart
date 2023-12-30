import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '/admin/controllers/menu_controller.dart' as MyMenuController;
import '../../../common/app_colors.dart';
import '../../../common/app_responsive.dart';
import '../../../../config.dart';

class HeaderWidget extends StatefulWidget {
  final String title;

  const HeaderWidget({super.key, required this.title});

  @override
  _HeaderWidgetState createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  late SharedPreferences prefs;

  Future<void> initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  Future<void> logout() async {
    try {
      final token = prefs.getString('token');
      final response = await http.post(
        Uri.parse(logoutapi),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        Provider.of<MyMenuController.MenuController>(context, listen: false)
            .setLoggedIn(false);
      } else {
        print('Logout failed with status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error during logout: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          if (!AppResponsive.isDesktop(context))
            IconButton(
              icon: Icon(
                Icons.menu,
                color: AppColor.black,
              ),
              onPressed: Provider.of<MyMenuController.MenuController>(context,
                      listen: false)
                  .controlMenu,
            ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  logout();
                },
                child: navigationIcon(icon: Icons.logout),
              ),
              navigationIcon(icon: Icons.send),
              navigationIcon(icon: Icons.notifications_none_rounded),
            ],
          ),
          const Spacer(),
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget navigationIcon({icon}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Icon(
        icon,
        color: AppColor.black,
      ),
    );
  }
}
