import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:ui' as ui;
import '../../../../config.dart';

import 'package:intl/intl.dart';

import '../../../../usrTime/screens/home/components/home_header.dart';
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
  late CalendarFormat _calendarFormat;
  DateTime _focusedDay = DateTime.now();
  late DateTime _selectedDay;

  // Events data structure
  Map<DateTime, List<Map<String, dynamic>>> _events = {};

  late String currentCompanyName; // Initialize here
  late String userName;
  late String location;
  late String companyName;
  @override
  void initState() {
    super.initState();
    _calendarFormat = CalendarFormat.month;
    _selectedDay = _focusedDay;

    // Fetch the company name when the app starts
    _fetchCurrentCompanyName();
    getCompanyName().then((value) {});
  }

  Future<void> getCompanyName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      companyName = prefs.getString('company') ?? '';
    });
  }

  Future<void> _fetchCurrentCompanyName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      currentCompanyName = prefs.getString('company') ?? '';
    });

    // Fetch orders for the initial date and company name
    _fetchOrders(_focusedDay, currentCompanyName);
  }

  Future<void> _fetchOrders(DateTime date, String companyName) async {
    if (currentCompanyName == null) {
      // Handle the case where currentCompanyName is not initialized yet
      return;
    }

    final formattedDate = DateFormat('yyyy-MM-dd').format(date);

    final response =
        await http.get(Uri.parse('$ordarforcom/$formattedDate/$companyName'));
    print('URL: $ordarforcom/$formattedDate/$companyName');
    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      final List<dynamic> orders = json.decode(response.body)['orders'];

      setState(() {
        _events[date] =
            orders.map<Map<String, dynamic>>((order) => order).toList();
      });
    } else {
      throw Exception('Failed to load orders');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: HomeHeader(),
        ),
        body: Column(
          children: <Widget>[
            TableCalendar(
              calendarStyle: const CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                selectedTextStyle: TextStyle(color: Colors.white),
              ),
              calendarFormat: _calendarFormat,
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });

                _fetchOrders(selectedDay, currentCompanyName);
              },
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              firstDay: DateTime(2022, 1, 1),
              lastDay: DateTime(2030, 12, 31),
              eventLoader: (day) {
                return _events[day] ?? [];
              },
            ),
            // Display event details
            Expanded(
              child: _buildEventDetails(),
            ),
          ],
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
                      return CalendarPage();
                    }),
                  );
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
                  // Navigate to the personal page
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
        ));
  }

  Widget _buildEventDetails() {
    final selectedEvents = _events[_selectedDay] ?? [];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var event in selectedEvents) _buildEventCard(event),
        ],
      ),
    );
  }

  Widget _buildEventCard(Map<String, dynamic> order) {
    String formattedDate = _formatDatabaseDate('2024-01-20T17:03:03.162+00:00');
    String userName = order['UserName'];
    String orderCode = order['OrderCode'];

    return Card(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        leading: IconButton(
          icon: const Icon(Icons.check, color: Colors.green),
          onPressed: () {
            _deleteOrder(order['OrderCode']);
          },
        ),
        trailing: const SizedBox(
          width: 1,
        ),
        title: Text(userName,
            textDirection: ui.TextDirection.rtl // Set the text direction to RTL
            ),
        subtitle: Text(orderCode,
            textDirection: ui.TextDirection.rtl // Set the text direction to RTL
            ),
      ),
    );
  }

  String _formatDatabaseDate(String databaseDate) {
    // تنسيق التاريخ من القاعدة بتنسيق مقروء
    DateTime date = DateTime.parse(databaseDate);
    String formattedDate = DateFormat('MMMM d, y HH:mm:ss').format(date);
    return formattedDate;
  }

  void _deleteOrder(String orderCode) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String companyName = prefs.getString('company') ?? '';

      final response = await http.delete(
        Uri.parse(deleteordar),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'OrderCode': orderCode,
          'companyName': companyName,
        }),
      );

      if (response.statusCode == 200) {
        // عملية الحذف تمت بنجاح
        // يمكنك إعادة تحميل الطلبات بعد الحذف إذا كنت بحاجة إلى تحديث الواجهة
        _fetchOrders(_selectedDay, companyName);
      } else {
        // فشلت عملية الحذف
        print('Failed to delete order. Status code: ${response.statusCode}');
        // يمكنك إضافة معالجة للخطأ هنا إذا كنت بحاجة إلى ذلك
      }
    } catch (error) {
      print('Error deleting order: $error');
      // يمكنك إضافة معالجة للخطأ هنا إذا كنت بحاجة إلى ذلك
    }
  }
}
