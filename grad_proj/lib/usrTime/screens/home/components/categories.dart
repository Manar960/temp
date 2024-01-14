import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../../config.dart';
import '../../favorite/favorite_screen.dart';
import 'DenemoDialog.dart';
import 'insurance_dialog.dart';
import 'toaria/Learning.dart';

class Categories extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const Categories({Key? key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {"icon": "assets/icon/d.png", "text": "تؤوريا"},
      {"icon": "assets/icon/h.png", "text": "المفضلة"},
      {"icon": "assets/icon/icons8-car-service-50.png", "text": "دنيمو ميتر"},
      {"icon": "assets/icon/icons8-document-30.png", "text": "خدمات حكومية"},
      {"icon": "assets/icon/icons8-comment-50.png", "text": "تقديم شكوى"},
    ];
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          categories.length,
          (index) => CategoryCard(
            icon: categories[index]["icon"],
            text: categories[index]["text"],
            press: () {
              if (index == 4) {
                _showComplaintDialog(context);
              }
              if (index == 3) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GovernmentServicesPage()),
                );
              }
              if (index == 2) {
                _showDenemoDialog(context);
              }
              if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const favScreen();
                  }),
                );
              }
              if (index == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LearningPage()),
                );
              } else {}
            },
          ),
        ),
      ),
    );
  }

  void _showComplaintDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ComplaintDialog();
      },
    );
  }
}

void _showDenemoDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return DenemoDialog();
    },
  );
}

// ignore: use_key_in_widget_constructors
class ComplaintDialog extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _ComplaintDialogState createState() => _ComplaintDialogState();
}

class _ComplaintDialogState extends State<ComplaintDialog> {
  String _selectedComplaintType = 'شكوى عن التطبيق';
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'تقديم شكوى',
        style: TextStyle(
          fontSize: 20,
          color: Color(0xFF063970),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _userEmailController,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFF063970),
            ),
            decoration: const InputDecoration(
              labelText: 'البريد الإلكتروني',
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF063970), width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1.0),
              ),
              alignLabelWithHint: true,
            ),
          ),
          const SizedBox(height: 16),
          DropdownButton<String>(
            value: _selectedComplaintType,
            items: ['شكوى عن التطبيق', 'شكوى عن الخدمات'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: const TextStyle(
                    color: Color(0xFF063970),
                    fontSize: 15,
                  ),
                ),
              );
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                _selectedComplaintType = value!;
              });
            },
            hint: const Text(
              'نوع الشكوى',
              style: TextStyle(
                color: Color(0xFF063970),
                fontSize: 15,
              ),
            ),
            style: const TextStyle(
              color: Color(0xFF063970),
              fontSize: 15,
            ),
            icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF063970)),
            underline: Container(
              height: 2,
              color: const Color(0xFF063970),
            ),
          ),
          if (_selectedComplaintType == 'شكوى عن الخدمات') ...[
            const SizedBox(height: 16),
            TextFormField(
              controller: _companyNameController,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF063970),
              ),
              decoration: const InputDecoration(
                labelText: 'اسم الشركة',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF063970), width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                ),
                alignLabelWithHint: true,
              ),
            ),
          ],
          const SizedBox(height: 16),
          TextFormField(
            controller: _commentController,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFF063970),
            ),
            decoration: const InputDecoration(
              labelText: 'محتوى الشكوى',
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF063970), width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1.0),
              ),
              alignLabelWithHint: true,
            ),
            maxLines: 3,
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            _sendCommentToServer();
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF063970),
          ),
          child: const Text(
            'تقديم',
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  void _sendCommentToServer() async {
    const url = addComm;
    late String t;
    late String companyName;
    if (_selectedComplaintType == 'شكوى عن الخدمات') {
      t = 'c';
      companyName = _companyNameController.text;
    } else {
      t = 'a';
      companyName = 'non';
      _sendNotificationToAdmin();
    }
    final response = await http.post(
      Uri.parse(url),
      body: json.encode({
        'UserEmail': _userEmailController.text,
        'Type': t,
        'companyName': companyName,
        'Comment': _commentController.text,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // ignore: avoid_print
      print('تم إرسال الكومنت بنجاح.');
    } else {
      // ignore: avoid_print
      print('خطأ في إرسال الكومنت: ${response.statusCode}');
    }
  }
}

void _sendNotificationToAdmin() async {
  await http.post(
    Uri.parse('https://fcm.googleapis.com/fcm/send'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization':
          'AAAA5jl26Ns:APA91bGK3T2lK0kWSaaVPUpOrnxUKv7nCPEM1mlTQ9Huxp23ntfDmmd96NuheFtJTy_QleQvCCstNvuh0BrThOa8FktLSUO-i5JlVN9nm0Gk-ejaeEYZd1EapC4a4EuelX-ML9KF90uG',
    },
    body: jsonEncode({
      'to':
          " dHJmQEnOAvlIubRwdSRrg9:APA91bFgm-RMhRaQRU4scMTLbL7NYBPGAQJsztTtkYtFS6rK7D92v58G4XU3bYVvRRlI_qV1qi0TrmnSFznvjLq2KpvHQICgCqQKLxuLF7nkE0kSUylYKBkf_rBls1zsMOi3NgJkthvF",
      'data': {
        'title': 'New Complaint',
        'body': 'A new complaint has been submitted .',
      },
    }),
  );
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String icon, text;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 150,
      child: ElevatedButton(
        onPressed: press,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF063970),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                color: const Color(0xFF063970),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(icon),
            ),
            const SizedBox(height: 4),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
