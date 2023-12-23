import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../config.dart';

class RecruitmentDataWidget extends StatefulWidget {
  const RecruitmentDataWidget({Key? key}) : super(key: key);

  @override
  _RecruitmentDataWidgetState createState() => _RecruitmentDataWidgetState();
}

class _RecruitmentDataWidgetState extends State<RecruitmentDataWidget> {
  List<Map<String, dynamic>> adminDataList = [];

  @override
  void initState() {
    super.initState();
    fetchAdminData();
  }

  Future<void> fetchAdminData() async {
    try {
      final response = await http.get(Uri.parse(getadmindata));
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        // Check if 'adminData' is not null and is an iterable
        if (jsonResponse['adminData'] != null &&
            jsonResponse['adminData'] is Iterable) {
          setState(() {
            adminDataList = List.from(jsonResponse['adminData']);
          });
        } else {
          throw Exception(
              'Invalid JSON response. "adminData" is null or not iterable.');
        }
      } else {
        throw Exception('Failed to load admin data');
      }
    } catch (error) {
      print('Error fetching admin data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "المشرفون",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 22,
                ),
                textDirection:
                    TextDirection.rtl, // Set text direction to right-to-left
              ),
            ],
          ),
          const Divider(
            thickness: 0.5,
            color: Colors.grey,
          ),
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              /// Table Header
              TableRow(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                      width: 0.5,
                    ),
                  ),
                ),
                children: [
                  tableHeader("البريد الإلكتروني"),
                  tableHeader("وقت الانضمام"),
                  tableHeader("الاسم الكامل"),
                ],
              ),

              /// Table Data
              for (final admin in adminDataList)
                tableRow(
                  context,
                  name: admin['adminName'],
                  designation: admin['createdAt'],
                  email: admin['email'],
                  color: Colors.yellow,
                  image: admin['latestProfilePicture'],
                ),
            ],
          ),
        ],
      ),
    );
  }

  TableRow tableRow(
    context, {
    String? name,
    String? designation,
    String? email,
    Color? color,
    String? image,
  }) {
    return TableRow(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 0.5,
          ),
        ),
      ),
      children: [
        // Status
        Row(
          textDirection: TextDirection.rtl,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color ?? Colors.grey,
              ),
              height: 10,
              width: 10,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              email ?? '',
              textDirection: TextDirection.rtl,
            ),
          ],
        ),
        // Designation
        Text(
          designation ?? '',
          textDirection: TextDirection.rtl,
        ),
        // Full Name with Image
        Container(
          margin: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              if (image != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(1000),
                  child: Image.network(
                    image,
                    width: 30,
                  ),
                ),
              if (image != null)
                const SizedBox(
                  width: 10,
                ),
              Text(
                name ?? '',
                textDirection: TextDirection.rtl,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget tableHeader(text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        textDirection: TextDirection.rtl,
      ),
    );
  }
}
