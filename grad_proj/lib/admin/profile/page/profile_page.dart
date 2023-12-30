import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import '../../../config.dart';
import '../../pages/dashboard/widget/header_widget.dart';
import '../widget/addminButoon.dart';
import '../widget/numbers_widget.dart';
import '../widget/profile_widget.dart';

class ProfilePagead extends StatefulWidget {
  final String adminEmail;

  const ProfilePagead({Key? key, required this.adminEmail}) : super(key: key);

  @override
  _ProfilePageStatead createState() => _ProfilePageStatead();
}

class _ProfilePageStatead extends State<ProfilePagead> {
  Map<String, dynamic>? adminData;
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
          .child(widget.adminEmail)
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
          .child(widget.adminEmail)
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
        future: fetchAdminData(),
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
    );
  }

  Widget buildProfileContent(Map<String, dynamic> adminData) {
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
          buildUserInfo(adminData),
          const SizedBox(height: 24),
          const NumbersWidget(),
          const SizedBox(height: 100),
          ProjectsView(
            key: UniqueKey(),
          ),
        ],
      ),
    );
  }

  Widget buildUserInfo(Map<String, dynamic> adminData) {
    return Column(
      children: [
        Text(
          adminData['adminName'] ?? 'user',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        const SizedBox(height: 4),
        Text(
          adminData['email'] ?? 'email',
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Future<Map<String, dynamic>> fetchAdminData() async {
    String e = widget.adminEmail;
    try {
      final response = await http.post(
        Uri.parse('$getAdminByEmailEndpoint?email=$e'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        if (jsonResponse.containsKey('createdAt')) {
          print(jsonResponse);
          return jsonResponse;
        } else {
          throw Exception('Error: \'createdAt\' field not found in admin data');
        }
      } else {
        throw Exception('Failed Request Status Code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error fetching admin data: $error');
    }
  }
}
