import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:file_picker/file_picker.dart';

import '../../../admin/pages/dashboard/widget/header_widget.dart';
import '../../../config.dart';
import '../../screens/forms/formscom.dart';
import '../../screens/home/calendar/calendar.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/stoks/stock.dart';
import '../widget/numbers_widget.dart';
import '../widget/profile_widget.dart';
import 'package:grad_proj/timeelinee/curved_navigation_bar.dart';

class ProfilePageadCompany extends StatefulWidget {
  final String companyName;

  const ProfilePageadCompany({Key? key, required this.companyName})
      : super(key: key);

  @override
  _ProfilePageCompanyStatead createState() => _ProfilePageCompanyStatead();
}

class _ProfilePageCompanyStatead extends State<ProfilePageadCompany> {
  Map<String, dynamic>? companyData;
  final String pageTitle = 'الملف الشخصي';
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    _initImage();
  }

  Future<void> _initImage() async {
    try {
      ListResult result = await FirebaseStorage.instance
          .ref()
          .child(widget.companyName)
          .listAll();

      List<Future<DateTime>> creationTimeFutures = result.items.map((file) {
        return file
            .getMetadata()
            .then((metadata) => metadata.timeCreated ?? DateTime(0));
      }).toList();

      List<DateTime> creationTimes = await Future.wait(creationTimeFutures);

      int latestIndex = creationTimes
          .indexOf(creationTimes.reduce((a, b) => a.isAfter(b) ? a : b));

      String latestFileURL = await result.items[latestIndex].getDownloadURL();

      setState(() {
        _imagePath = latestFileURL;
      });
    } catch (error) {
      print("Error initializing image: $error");
    }
  }

  Future<void> _pickImage() async {
    FilePickerResult? result;

    result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg'],
    );

    if (result != null) {
      Uint8List? uploadFile = result.files.single.bytes;
      String fileName = result.files.single.name;

      Reference reference = FirebaseStorage.instance
          .ref()
          .child(widget.companyName)
          .child(fileName);

      final UploadTask uploadTask = reference.putData(uploadFile!);

      await uploadTask.whenComplete(() async {
        reference.getDownloadURL().then((fileURL) {
          setState(() {
            _imagePath = fileURL;
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchCompanyData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            return buildProfileContent(snapshot.data!);
          } else {
            return const Center(child: Text("No data available."));
          }
        },
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const HomeScreencom();
                  }),
                );
                break;
              case 1:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const CalendarPage();
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return ProfilePageadCompany(
                      companyName: companyData?['Name'] ?? '',
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

  Widget buildProfileContent(Map<String, dynamic> companyData) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const HeaderWidget(
            title: 'الملف الشخصي',
          ),
          ProfileWidget(
            imagePath: _imagePath ??
                'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
            onClicked: () async {
              _pickImage();
            },
          ),
          const SizedBox(height: 24),
          buildUserInfo(companyData),
          const SizedBox(height: 24),
          NumbersWidget(),
          const SizedBox(height: 100),
          buildAbout(context), // تم استبدال هنا
        ],
      ),
    );
  }

  Widget buildUserInfo(Map<String, dynamic> companyData) {
    return Column(
      children: [
        Text(
          companyData['Name'] ?? 'Company Name',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        const SizedBox(height: 4),
        Text(
          companyData['email'] ?? 'Email',
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Future<Map<String, dynamic>> fetchCompanyData() async {
    String companyName = widget.companyName;
    print("from profile $companyName");

    try {
      final response = await http.get(
        Uri.parse('$getCompanyInfo/$companyName'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic>? jsonResponse = json.decode(response.body);

        if (jsonResponse != null && jsonResponse['status'] == true) {
          final Map<String, dynamic>? companyData = jsonResponse['companyInfo'];
          String comtaype = companyData?['Type'];

          print("company type $comtaype");
          String comloc = companyData?['Type'];

          print("company type $comloc");
          if (companyData != null) {
            return companyData;
          } else {
            print(jsonResponse);
            return {}; // Provide a default value or an empty map if 'companyInfo' is not found
          }
        } else {
          throw Exception('Failed Request Status Code: ${response.statusCode}');
        }
      } else {
        throw Exception('Failed Request Status Code: ${response.statusCode}');
      }
    } catch (error) {
      print("Error fetching company data: $error");
      throw Exception('Error fetching company data: $error');
    }
  }

  Widget buildAbout(BuildContext context) {
    print("from profile2 $companyData?['location']");
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Card(
          color: Colors.white,
          margin: const EdgeInsets.symmetric(vertical: 9.0, horizontal: 20.0),
          child: ListTile(
            leading: const Icon(
              Icons.work,
              color: Colors.black,
              size: 30.0,
            ),
            title: Text(
              companyData?['Type'] ?? 'Location Not Available',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontFamily: 'Source Sans Pro',
              ),
            ),
          ),
        ),
        Card(
          color: Colors.white,
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
          child: ListTile(
            leading: const Icon(
              Icons.location_city,
              color: Colors.black,
              size: 30.0,
            ),
            title: Text(
              companyData?['location'] ?? 'Location Not Available',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontFamily: 'Source Sans Pro',
              ),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            showEditProfileDialog(context);
          },
          child: const Text('تعديل المعلومات'),
        ),
      ],
    );
  }

  void showEditProfileDialog(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('تحرير المعلومات'),
          content: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'الاسم',
                ),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'البريد الإلكتروني',
                ),
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'كلمة المرور',
                ),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('إلغاء'),
            ),
            ElevatedButton(
              // Handle the editing logic here
              onPressed: () async {
                // Handle the editing logic here
                String newName = nameController.text;
                String newEmail = emailController.text;
                String newPassword = passwordController.text;

                // Send a request to update company information
                try {
                  await updateCompanyInfo(
                      companyData?['Name'], newName, newEmail, newPassword);
                  print('Company information updated successfully');
                } catch (error) {
                  print('Failed to update company information: $error');
                }

                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('حفظ'),
            ),
          ],
        );
      },
    );
  }

  Future<void> updateCompanyInfo(String companyName, String newName,
      String newEmail, String newPassword) async {
    final String updateCompanyInfoEndpoint = '$updateCompanyInfo/$companyName';

    await http.put(
      Uri.parse(updateCompanyInfoEndpoint),
      body: jsonEncode({
        'updatedInfo': {
          'Name': newName,
          'email': newEmail,
          'password': newPassword,
        },
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );
  }
}
