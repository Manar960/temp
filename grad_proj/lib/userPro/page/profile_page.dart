import 'dart:convert';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:grad_proj/timeelinee/profilecompany/%20%20%20%20model/user.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../../admin/pages/dashboard/widget/header_widget.dart';
import '../../admin/profile/widget/numbers_widget.dart';
import '../../admin/profile/widget/profile_widget.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  final token;
  final userName;

  const ProfilePage({Key? key, required this.token, required this.userName})
      : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String email;
  late String name;

  final String pageTitle = 'الملف الشخصي';

  String? _imagePath;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    email = jwtDecodedToken['email'];
    name = jwtDecodedToken['userName'] ?? 'user';
    _initImage();
  }

  Future<void> _initImage() async {
    try {
      ListResult result =
          await FirebaseStorage.instance.ref().child(name).listAll();

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

      Reference reference =
          FirebaseStorage.instance.ref().child(name).child(fileName);

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
    return FutureBuilder<User>(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final user = snapshot.data;
          return Scaffold(
            body: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraints.maxHeight),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const HeaderWidget(title: 'الملف الشخصي'),
                        ProfileWidget(
                          imagePath: _imagePath ??
                              'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
                          onClicked: () async {
                            _pickImage();
                          },
                        ),
                        const SizedBox(height: 24),
                        buildName(user),
                        const SizedBox(height: 24),
                        const NumbersWidget(),
                        const SizedBox(height: 48),
                        buildAbout(context),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Widget buildName(User? user) => Column(
        children: [
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            email,
            style: const TextStyle(color: Colors.black),
          ),
        ],
      );

  Widget buildAbout(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Card(
          color: Colors.white,
          margin: EdgeInsets.symmetric(vertical: 9.0, horizontal: 20.0),
          child: ListTile(
            leading: Icon(
              Icons.work,
              color: Colors.black,
              size: 30.0,
            ),
            title: Text(
              'Location Not Available',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontFamily: 'Source Sans Pro',
              ),
            ),
          ),
        ),
        const Card(
          color: Colors.white,
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
          child: ListTile(
            leading: Icon(
              Icons.location_city,
              color: Colors.black,
              size: 30.0,
            ),
            title: Text(
              'Location Not Available',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontFamily: 'Source Sans Pro',
              ),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            updateUserInformation();
          },
          child: const Text('تعديل المعلومات'),
        ),
      ],
    );
  }

  Future<void> updateUserInformation() async {
    try {
      Map<String, dynamic> requestBody = {
        "userFirstName": nameController.text,
        // "password": passwordController.text, // Uncomment if needed
        // Add other fields as needed
      };

      var response = await http.put(
        Uri.parse('YOUR_SERVER_API_ENDPOINT/update-user-info/$email'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${widget.token}',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        print('User information updated successfully');
      } else {
        print('Failed to update user information: ${response.body}');
      }
    } catch (error) {
      print('Error updating user information: $error');
    }

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
              onPressed: () async {
                // await updateUserInformation();
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('حفظ'),
            ),
          ],
        );
      },
    );
  }
}
