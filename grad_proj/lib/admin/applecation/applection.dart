import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../config.dart';
import '../common/app_colors.dart';
import '../pages/dashboard/widget/header_widget.dart';
import "package:mailer/mailer.dart";
import "package:mailer/smtp_server.dart";

Future fetchCompanyInformation() async {
  try {
    var response = await http.get(
      Uri.parse(info),
    );
    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');
    var jsonResponse = jsonDecode(response.body);

    if (jsonResponse['status']) {
      List<Company> fetchedCompanies = [];

      for (var companyData in jsonResponse['matchingCompanies']) {
        Company company = Company(
          name: companyData['Name'],
          email: companyData['email'],
          type: companyData['Type'],
        );

        fetchedCompanies.add(company);
      }

      // Return the list of companies
      return fetchedCompanies;
    }
  } catch (e) {
    print('Error fetching company information: $e');
    // Return an empty list in case of an error
    return [];
  }
}

final smtpServer = gmail('batoolsh2001@gmail.com', 'shilleh@2021');

Future<void> sendEmail(String email) async {
  final message = Message()
    ..from = const Address('batoolsh2001@gmail.com', 'Batool D Shilleh')
    ..recipients.add(email)
    ..subject = 'قبول طلبك'
    ..text = 'مبارك ! لقد أصبحت جزء من مجتمعنا سجل دخول الآن ';

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: $sendReport');
  } catch (e) {
    print('Error sending email: $e');
  }
}

Future<void> deletePayService(String name) async {
  try {
    var response = await http.delete(
      Uri.parse('$denaypay/$name'),
    );

    if (response.statusCode == 200) {
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      print('Pay deleted successfully');
    } else {
      print('Failed to delete pay. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error deleting pay: $e');
  }
}

Future<void> updateAccseptService(String email) async {
  try {
    var response = await http.put(
      Uri.parse('$updateAccsept/$email'),
    );

    if (response.statusCode == 200) {
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      print('Accsept status updated successfully');
    } else {
      print(
          'Failed to update Accsept status. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error updating Accsept status: $e');
  }
}

Future<void> deleteAppService(String name) async {
  try {
    var response = await http.delete(
      Uri.parse('$denayapp/$name'),
    );

    if (response.statusCode == 200) {
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      print('Pay deleted successfully');
    } else {
      print('Failed to delete pay. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error deleting pay: $e');
  }
}

class Company {
  late String name;
  late String email;
  late String type;

  Company({
    required this.name,
    required this.email,
    required this.type,
  });
}

class ApplicationList extends StatefulWidget {
  const ApplicationList({super.key});

  @override
  _ApplicationListState createState() => _ApplicationListState();
}

class _ApplicationListState extends State<ApplicationList> {
  List<Company> companies = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    List<Company> result = await fetchCompanyInformation();
    setState(() {
      companies = result;
    });
  }

  Future<void> onDelete(String companyName) async {
    await deletePayService(companyName);
    await deleteAppService(companyName);
    await fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColor.bgColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          const HeaderWidget(
            title: 'Application',
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var company in companies)
                    CompanyCard(
                      companyName: company.name,
                      email: company.email,
                      type: company.type,
                      onDelete: () => onDelete(company.name),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CompanyCard extends StatelessWidget {
  final String companyName;
  final String email;
  final String type;
  final Function onDelete;

  const CompanyCard({super.key, 
    required this.companyName,
    required this.email,
    required this.type,
    required this.onDelete,
  });

  Future<void> onUpdateAccept() async {
    try {
      await updateAccseptService(companyName);

      var response = await http.put(
        Uri.parse('$comreg/$companyName'),
      );

      if (response.statusCode == 200) {
        print('Second HTTP request successful');
      } else {
        print(
            'Failed to make the second HTTP request. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating accept status: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        title: Text(companyName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Email: $email'),
            Text('Type: $type'),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () async {
                onDelete();
              },
              icon: const Icon(Icons.close, color: Colors.red),
            ),
            IconButton(
              onPressed: () async {
                await updateAccseptService(email);
                await onUpdateAccept();
                onDelete();
                sendEmail(email);
              },
              icon: const Icon(Icons.check, color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
