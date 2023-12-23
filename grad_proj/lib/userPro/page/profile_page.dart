import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../../admin/profile/    model/user.dart';
import '../../admin/profile/widget/button_widget.dart';
import '../../admin/profile/widget/numbers_widget.dart';
import '../../admin/profile/widget/profile_widget.dart';

import '../utils/user_preferences.dart';

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
  Uint8List? _image;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    email = jwtDecodedToken['email'];
    name = widget.userName ?? 'user';
  }

  void selectImage() async {
    Uint8List? img = await UserPreferences.pickImage(ImageSource.gallery);

    setState(() {
      _image = img;
    });
  }

  void saveprofile() async {
    if (_image != null) {
      // String resp = await StoreData().saveData(file: _image!);
      // print(resp);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: UserPreferences.getUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final user = snapshot.data;
          return Scaffold(
            appBar: buildAppBar(context),
            body: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraints.maxHeight),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ProfileWidget(
                          onClicked: selectImage,
                          imagePath: user?.imagePath ?? '',
                          imageBytes: _image,
                        ),
                        const SizedBox(height: 24),
                        buildName(user),
                        const SizedBox(height: 24),
                        Center(child: buildUpgradeButton(context)),
                        const SizedBox(height: 24),
                        NumbersWidget(),
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
          return CircularProgressIndicator();
        }
      },
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('عنوان الصفحة'),
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
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

  Widget buildUpgradeButton(BuildContext context) => ButtonWidget(
        text: 'تسجيل الخروج',
        onClicked: () {
          saveprofile();
        },
      );

  Widget buildAbout(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Card(
          color: Colors.white,
          margin: EdgeInsets.symmetric(vertical: 9.0, horizontal: 20.0),
          child: ListTile(
            leading: Icon(
              Icons.work,
              color: Colors.black,
              size: 30.0,
            ),
            title: Text(
              'Heart Pirate Leader',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontFamily: 'Source Sans Pro',
              ),
            ),
          ),
        ),
        Card(
          color: Colors.white,
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
          child: ListTile(
            leading: Icon(
              Icons.currency_bitcoin,
              color: Colors.black,
              size: 30.0,
            ),
            title: Text(
              '500.000.000',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontFamily: 'Source Sans Pro',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
