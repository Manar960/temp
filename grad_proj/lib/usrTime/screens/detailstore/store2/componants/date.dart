import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

import '../../../../../config.dart';
import '../../../booking/boking_screen.dart';
import '../../../dialog.dart';

class DatePage extends StatefulWidget {
  const DatePage(
      {Key? key, required this.name, required this.image, required this.user})
      : super(key: key);
  final String name, image, user;

  @override
  _DatePageState createState() => _DatePageState();
}

class _DatePageState extends State<DatePage> {
  late String time;
  int selectedTimeIndex = 0;
  // ignore: prefer_final_fields
  TextEditingController _dateController = TextEditingController();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? combinedDateTime;
  late DateTime formattedDateTime;
  bool bookingStatus = false;
  @override
  void initState() {
    super.initState();
    booking(widget.name);
  }

  List? Avalid;
  Future booking(String storeName) async {
    final url = '$checkTimeAndDayCom/$storeName';

    final response = await http.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      setState(() {
        Avalid = jsonResponse['Avalid'];
      });
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

  Future Booking(String StoreName, String userName, String Storeimage,
      DateTime date, String time) async {
    final response = await http.post(
      Uri.parse(bookingUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'StoreName': StoreName,
        'UserName': userName,
        'Storeimage': Storeimage,
        'date': date.toUtc().toIso8601String(),
        'time': time
      }),
    );

    if (response.statusCode == 200) {
      print("ok");
    } else {
      print('Failed to make booking. Status code: ${response.statusCode}');
    }
  }

  List<String> getAvailableTimesForSelectedDay() {
    if (Avalid != null && _selectedDay != null) {
      var selectedDayEntry = Avalid!.firstWhere(
        (entry) => entry['day'] == DateFormat('EEEE').format(_selectedDay!),
        orElse: () => null,
      );

      if (selectedDayEntry != null) {
        return List<String>.from(
            selectedDayEntry['hours'].map((timeEntry) => timeEntry['time']));
      }
    }

    return [];
  }

  Future<bool> findDate(
      String storeName, String userName, DateTime date, String time) async {
    String formattedDate = date.toUtc().toIso8601String();
    print(formattedDate);

    try {
      final response = await http.post(
        Uri.parse(checkTimeAndDay),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'StoreName': storeName,
          'UserName': userName,
          'date': date.toUtc().toIso8601String(),
          'time': time
        }),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final bool status = responseData['status'];

        return status;
      } else {
        print('Failed to make booking. Status code: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      print('Error: $error');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> availableTimes = getAvailableTimesForSelectedDay();

    return Scaffold(
      appBar: AppBar(
        title: const Text('حجز موعد'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TableCalendar(
                  firstDay: DateTime.utc(2000, 1, 1),
                  lastDay: DateTime.utc(2100, 12, 31),
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onFormatChanged: (format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  },
                  onDaySelected: (selectedDay, focusedDay) async {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                      _dateController.text =
                          selectedDay.toLocal().toString().split(" ")[0];
                    });
                  },
                ),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    'الوقت',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                availableTimes.isEmpty
                    ? const Center(
                        child: Text(
                          "لا يوجد اوقات متاحة",
                          style: TextStyle(fontSize: 20.0, color: Colors.black),
                        ),
                      )
                    : GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                          childAspectRatio: 2,
                        ),
                        itemCount: getAvailableTimesForSelectedDay().length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () async {
                              setState(() {
                                selectedTimeIndex = index;
                              });
                              bookingStatus = await findDate(
                                  widget.name,
                                  username!,
                                  _selectedDay!,
                                  availableTimes[index]);
                              if (bookingStatus) {
                                // ignore: use_build_context_synchronously
                                showCards(context, "assets/booked.json",
                                    'هذا الوقت محجوز');
                              } else {
                                time = availableTimes[index];
                              }

                              print(time);
                            },
                            child: Card(
                              color: selectedTimeIndex == index
                                  ? const Color.fromARGB(255, 172, 207, 244)
                                  : const Color.fromARGB(255, 208, 215, 10),
                              child: Center(
                                child: Text(
                                  availableTimes[index],
                                  style: const TextStyle(fontSize: 20.0),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                const SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    height: 40,
                    width: 200,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFF063970),
                      ),
                      onPressed: () async {
                        Booking(widget.name, widget.user, widget.image,
                            _selectedDay!, time.toString());
                        showCards(
                            context, "assets/assets/sad.json", 'تم الحجز');

                        print(bookingStatus);

                        _dateController.text = "";
                        selectedTimeIndex = 0;
                      },
                      child: const Text(
                        "احجز",
                        style: TextStyle(
                            color: Colors.white, height: 1, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
