import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../login/Login/login_screen.dart';
import '/admin/controllers/menu_controller.dart' as MyMenuController;
import '../../../common/app_colors.dart';
import '../../../common/app_responsive.dart';
import '../../../../config.dart';

// Step 1: Create a NotificationModel class
class NotificationModel {
  final String message;
  final DateTime timestamp;

  NotificationModel({required this.message, required this.timestamp});
}

// Step 2: Create a NotificationScreen widget
class NotificationScreen extends StatelessWidget {
  final List<NotificationModel> notifications;

  const NotificationScreen({required this.notifications});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return ListTile(
            title: Text(notification.message),
            subtitle: Text('${notification.timestamp}'),
          );
        },
      ),
    );
  }
}

// Step 3: Create a NotificationIcon widget
class NotificationIcon extends StatelessWidget {
  final VoidCallback onTap;

  const NotificationIcon({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(Icons.notifications_none_rounded, color: AppColor.black),
    );
  }
}

class HeaderWidget extends StatefulWidget {
  final String title;

  const HeaderWidget({Key? key, required this.title}) : super(key: key);

  @override
  _HeaderWidgetState createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  late SharedPreferences prefs;
  List<NotificationModel> notifications = [];

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

  void _showNotification() {
    Fluttertoast.showToast(
      msg: 'لديك إشعار جديد!',
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );

    final newNotification = NotificationModel(
      message: 'لديك إشعار جديد!',
      timestamp: DateTime.now(),
    );

    setState(() {
      notifications.add(newNotification);
    });
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
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return const LoginScreen();
                    }),
                  );
                },
                child: navigationIcon(icon: Icons.logout),
              ),
              navigationIcon(icon: Icons.send),
              GestureDetector(
                onTap: () {
                  _showNotification();
                  Future.delayed(Duration(seconds: 2), () {
                    setState(() {
                      notifications.clear();
                    });
                  });
                },
                child: NotificationIcon(onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          NotificationScreen(notifications: notifications),
                    ),
                  );
                }),
              ),
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
