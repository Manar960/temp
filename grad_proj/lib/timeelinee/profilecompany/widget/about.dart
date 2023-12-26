import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black12,
        body: SafeArea(
          child: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
              const Text(
                'Trafegar Water D Low',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Pacifico',
                ),
              ),
              const Text(
                'surgeon',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20.0,
                  fontFamily: 'Source Sans Pro',
                ),
              ),
              const SizedBox(
                height: 20.0,
                width: 150.0,
                child: Divider(
                  color: Colors.white,
                ),
              ),
              buildInfoCard(
                icon: Icons.work,
                title: 'Heart Pirate Leader',
                value: '500.000.000',
                onPressed: () {
                  showEditDialog(context, 'Heart Pirate Leader');
                },
              ),
              buildInfoCard(
                icon: Icons.currency_bitcoin,
                title: '500.000.000',
                onPressed: () {
                  showEditDialog(context, '500.000.000');
                },
                value: '10000',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoCard(
      {required IconData icon,
      required String title,
      required String value,
      VoidCallback? onPressed}) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.black,
          size: 30.0,
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontFamily: 'Source Sans Pro',
          ),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16.0,
            fontFamily: 'Source Sans Pro',
          ),
        ),
        onTap: onPressed,
      ),
    );
  }

  Future<void> showEditDialog(BuildContext context, String initialValue) async {
    TextEditingController textController =
        TextEditingController(text: initialValue);

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('تحرير المعلومات'),
          content: TextField(
            controller: textController,
            decoration: const InputDecoration(
              hintText: 'أدخل القيمة الجديدة',
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('إلغاء'),
            ),
            ElevatedButton(
              onPressed: () {
                // هنا يمكنك تحديث المعلومات في الواجهة أو إرسالها إلى الخادم
                print('القيمة الجديدة: ${textController.text}');
                Navigator.of(context).pop();
              },
              child: const Text('حفظ'),
            ),
          ],
        );
      },
    );
  }
}
