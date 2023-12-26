import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../curved_navigation_bar.dart';
import '../../../profilecompany/page/profile_page_company.dart';
import '../../forms/formscom.dart';
import '../../stoks/stock.dart';
import '../home_screen.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late String companyName;

  @override
  void initState() {
    super.initState();
    _getCompanyName();
  }

  Future<void> _getCompanyName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      companyName = prefs.getString('company') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Calendar'),
      ),
      body: MonthView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showEventDialog(context);
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: Container(
        color: const Color(0xFF063970),
        child: CurvedNavigationBar(
          index: 1, // Set the index to 1 for CalendarPage
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return HomeScreencom();
                  }),
                );
                break;

              case 1:
                // Stay on the current page (CalendarPage)
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return ProfilePageadCompany(
                      companyName: companyName,
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

  void _showEventDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Event'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Event Title'),
                onChanged: (title) {
                  // Handle title changes
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  _addEvent(context);
                  Navigator.pop(context);
                },
                child: Text('Add Event'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _addEvent(BuildContext context) {
    final eventController = CalendarControllerProvider.of(context).controller;
    final event = CalendarEventData(
      date: DateTime.now(),
      event: 'Event Title',
      title: '',
    );
    eventController.add(event);
  }
}
