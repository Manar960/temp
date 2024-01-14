import 'dart:convert';
import 'package:flutter/material.dart';
import 'servicecard.dart';
import 'package:http/http.dart' as http;

class ServiceSection extends StatefulWidget {
  const ServiceSection({
    Key? key,
    required this.name,
  }) : super(key: key);

  final String name;

  @override
  _ServiceSectionState createState() => _ServiceSectionState();
}

class _ServiceSectionState extends State<ServiceSection> {
  List? services;

  Future<void> getserv(String storeName) async {
    final url = 'http://localhost:4000/getservices';

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "Name": storeName,
      }),
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      setState(() {
        services = jsonResponse['services'];
      });
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    getserv(widget.name);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            services!.length,
            (index) => ServiceCard(index: index, services: services),
          ),
        ),
      ),
    );
  }
}