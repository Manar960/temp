import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../common/app_colors.dart';
import '../../../../config.dart';

class ProfileCardWidget extends StatefulWidget {
  final String adminEmail;

  const ProfileCardWidget({Key? key, required this.adminEmail})
      : super(key: key);

  @override
  _ProfileCardWidgetState createState() => _ProfileCardWidgetState();
}

class _ProfileCardWidgetState extends State<ProfileCardWidget> {
  Map<String, dynamic>? adminData;
  String? _latestProfilePicture;

  @override
  void initState() {
    super.initState();
    if (widget.adminEmail.isNotEmpty) {
      fetchAdminData();
      fetchLatestProfilePicture();
    } else {
      print('Error: Please provide a non-empty admin email');
    }
  }

  Future<void> fetchAdminData() async {
    String e = widget.adminEmail;
    try {
      final response = await http.post(
        Uri.parse('$getAdminByEmailEndpoint?email=$e'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        if (jsonResponse.containsKey('createdAt')) {
          setState(() {
            adminData = jsonResponse;
          });
        } else {
          print("Error: 'createdAt' field not found in admin data");
        }
      } else {
        print("Failed Request Status Code: ${response.statusCode}");
        print("Failed Response Body: ${response.body}");
        throw Exception('Failed to load admin data');
      }
    } catch (error) {
      print('Error fetching admin data: $error');
    }
  }

  Future<void> fetchLatestProfilePicture() async {
    try {
      ListResult result = await FirebaseStorage.instance
          .ref()
          .child(widget.adminEmail)
          .listAll();

      if (result.items.isNotEmpty) {
        String latestFileURL = await result.items.last.getDownloadURL();
        setState(() {
          _latestProfilePicture = latestFileURL;
        });
      }
    } catch (error) {
      print('Error fetching latest profile picture: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          if (adminData != null)
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(
                    _latestProfilePicture! ??
                        'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      adminData!['adminName'] ?? '',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Text("Admin"),
                  ],
                )
              ],
            ),
          if (adminData != null)
            const Divider(
              thickness: 0.5,
              color: Colors.grey,
            ),
          if (adminData != null)
            profileListTile("Joined Date", adminData!['createdAt']),
          if (adminData != null) profileListTile("Projects", widget.adminEmail),
        ],
      ),
    );
  }

  Widget profileListTile(text, value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text),
          Text(
            value,
            style:
                TextStyle(fontWeight: FontWeight.bold, color: AppColor.black),
          ),
        ],
      ),
    );
  }
}
