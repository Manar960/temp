// ignore: file_names
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:grad_proj/admin/profile/widget/profileshos.dart';
import 'package:http/http.dart' as http;
import '../../../config.dart';
import '../../../landing/navebar/utils/theme_selector.dart';
import 'viwwabber.dart';

class ProjectsView extends StatefulWidget {
  const ProjectsView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProjectsViewState createState() => _ProjectsViewState();
}

class _ProjectsViewState extends State<ProjectsView> {
  late double screenWidth;
  late double screenHeight;
  int selectedIndex = 0;
  List<btton> projects = [
    btton(
      title: 'إضافة مسؤول',
      imageURL: 'assets/addadm.png',
    ),
    btton(
      title: 'إزالة مسؤول',
      imageURL: 'assets/deletadm.png',
    ),
    btton(
      title: 'إضافة خبير',
      imageURL: 'assets/addex.png',
    ),
  ];

  @override
  void didChangeDependencies() {
    precacheImage(const AssetImage('assets/login.json'), context);
    precacheImage(const AssetImage('assets/sighnup.json'), context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return ViewWrapper(
      desktopView: desktopView(),
      mobileView: mobileView(),
      key: const Key('20'),
    );
  }

//fpr desktop
  Widget desktopView() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: projects
              .asMap()
              .entries
              .map(
                (entry) => Column(
                  children: [
                    GestureDetector(
                      onTap: () => onImageTap(entry.key, context),
                      child: ProjectImage(
                        project: entry.value,
                        key: UniqueKey(),
                        onPressed: () {
                          onImageTap(entry.key, context);
                        },
                      ),
                    ),
                    Text(
                      entry.value.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget mobileView() {
    List<Widget> projectList = List.generate(projects.length, (index) {
      return Column(
        children: [
          Text(
            projects[index].title,
            style: ThemeSelector.selectSubHeadline(context),
          ),
          SizedBox(height: screenHeight * 0.01),
          ElevatedButton(
            onPressed: () => updateIndex(index),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              padding: const EdgeInsets.all(0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                projects[index].imageURL,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
        ],
      );
    });
    return Column(children: projectList);
  }

  void updateIndex(int newIndex) {
    setState(() {
      selectedIndex = newIndex;
      onImageTap(newIndex, context);
    });
  }
}

final TextEditingController _nameController = TextEditingController();
final TextEditingController _emailController = TextEditingController();
//add expport
void _showInputDialogAddExp(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('ادخل اسم المستخدم '),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'الاسم'),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              String name = _nameController.text;
              Navigator.of(context).pop();

              updateIsExpertByUsername(name);
            },
            child: const Text('موافق'),
          ),
        ],
      );
    },
  );
}

//اضافة ادمن

final TextEditingController _nameControlleradd = TextEditingController();
final TextEditingController _emailControlleradd = TextEditingController();
final TextEditingController _passControlleradd = TextEditingController();
void _showInputDialogAdmin(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('إدخال معلومات'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: _nameControlleradd,
              decoration: const InputDecoration(labelText: ' الاسم'),
            ),
            TextField(
              controller: _emailControlleradd,
              decoration: const InputDecoration(labelText: 'البريد الإلكتروني'),
            ),
            TextField(
              controller: _passControlleradd,
              decoration: const InputDecoration(labelText: 'كلمة السر'),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              String name = _nameControlleradd.text;
              String email = _emailControlleradd.text;
              String pass = _passControlleradd.text;
              Navigator.of(context).pop();
              registadmin();
            },
            child: const Text('موافق'),
          ),
        ],
      );
    },
  );
}

void onImageTap(int index, BuildContext context) {
  if (index == 0) {
    _showInputDialogAdmin(context);
  } else if (index == 1) {
    _showInputDialogDeleteAdmin(context);
  } else if (index == 2) {
    _showInputDialogAddExp(context);
  }
}

//تسجيل ادمن
void registadmin() async {
  if (_nameControlleradd.text.isNotEmpty &&
      _emailControlleradd.text.isNotEmpty &&
      _passControlleradd.text.isNotEmpty) {
    var regBody = {
      "adminName": _nameControlleradd.text,
      "email": _emailControlleradd.text,
      "password": _passControlleradd.text,
    };
    var response = await http.post(Uri.parse(registrationadmin),
        headers: {
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*'
        },
        body: jsonEncode(regBody));
    if (response.statusCode == 200) {}
  }
}

//تحويل المستخدم لخبير
void updateIsExpertByUsername(String username) async {
  var updateBody = {
    "UserName": username,
    "isExpert": true,
  };
  const url = 'https://gp-back-gp.onrender.com/';
  late String export = "${url}update-expert-status/$username?newStatus=true";
  var updateResponse = await http.put(
    Uri.parse(export),
    headers: {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': '*/*'
    },
    body: jsonEncode(updateBody),
  );

  if (updateResponse.statusCode == 200) {
    print('تم تحديث قيمة isExpert بنجاح');
  } else {
    print('فشل في تحديث قيمة isExpert');
  }
}

//حذف حسب الايميا
void _showInputDialogDeleteAdmin(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('حذف المسؤول'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'البريد الإلكتروني'),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              String email = _emailController.text;
              Navigator.of(context).pop();

              deleteAdminByEmail(email);
            },
            child: const Text('موافق'),
          ),
        ],
      );
    },
  );
}

//حذف الادمن حسب الايميل
void deleteAdminByEmail(String email) async {
  if (email.isNotEmpty) {
    var deleteBody = {
      "email": email,
    };
    var response = await http.post(Uri.parse(deleteadminbyemail),
        headers: {
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*'
        },
        body: jsonEncode(deleteBody));
  }
}
