import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late CalendarFormat _calendarFormat;
  DateTime _focusedDay = DateTime.now();
  late DateTime _selectedDay;

  // Events data structure
  Map<DateTime, List<String>> _events = {
    DateTime(2022, 1, 15): ['Event 1', 'Event 2'],
    DateTime(2022, 2, 10): ['Event 3'],
    // Add more events as needed
  };

  @override
  void initState() {
    super.initState();
    _calendarFormat = CalendarFormat.month;
    _selectedDay = _focusedDay;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar Page'),
      ),
      body: Column(
        children: <Widget>[
          TableCalendar(
            calendarStyle: CalendarStyle(
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
    );
  }

  Widget _buildEventDetails() {
    final selectedEvents = _events[_selectedDay] ?? [];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Event Details for $_selectedDay:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          for (var event in selectedEvents)
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(event),
            ),
        ],
      ),
    );
  }
}
