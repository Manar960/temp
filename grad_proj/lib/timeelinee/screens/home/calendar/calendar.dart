import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart'; // Import the connectivity package

import '../../../../config.dart';
import '../../../curved_navigation_bar.dart';
import '../../../profilecompany/page/profile_page_company.dart';
import '../../forms/formscom.dart';
import '../../stoks/stock.dart';
import '../home_screen.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late String companyName;

  // Add a GlobalKey to access the state
  final GlobalKey<_CalendarPageState> _calendarKey =
      GlobalKey<_CalendarPageState>();

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
        title: const Text('Event Calendar'),
      ),
      body: const MonthView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showEventDialog(context);
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: Container(
        color: const Color(0xFF063970),
        child: CurvedNavigationBar(
          index: 1,
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
                    return const HomeScreencom();
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
                    return const MyButtonsScreen();
                  }),
                );
                break;

              case 3:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const StokScreenPage();
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
          title: const Text('Add Event'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Event Title'),
                onChanged: (title) {
                  // Handle title changes
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  _addEvent();
                  Navigator.pop(context);
                },
                child: const Text('Add Event'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _addEvent() async {
    try {
      // Check for internet connectivity
      final result = await Connectivity().checkConnectivity();
      if (result == ConnectivityResult.none) {
        print('No internet connection');
        return;
      }

      // Check if the widget is still mounted
      if (!_calendarKey.currentState!.mounted) {
        return;
      }

      final response = await http.get(
        Uri.parse('$getbookinginfo/$companyName'),
      );

      if (response.statusCode == 200) {
        final List<dynamic>? bookings = json.decode(response.body)['bookings'];

        if (bookings != null) {
          for (var booking in bookings) {
            final DateTime date = DateTime.parse(booking['date']);
            final String eventTitle = 'Booking: ${booking['BookingCode']}';
            print("eventTitle $eventTitle");
            print("date $date");

            // Use the GlobalKey to access the controller
            final eventController =
                CalendarControllerProvider.of(_calendarKey.currentContext!)
                    .controller;

            final event = CalendarEventData(
              date: date,
              event: eventTitle,
              title: eventTitle,
            );

            eventController.add(event);
          }
        } else {
          print('Bookings field is null or absent');
        }
      } else {
        print('Failed to load bookings. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching bookings: $e');
    }
  }
}
