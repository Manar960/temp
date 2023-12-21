import 'dart:typed_data';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import '../../admin/profile/    model/user.dart';

class UserPreferences {
  static const _keyImagePath = 'user_image_path';
  static const _keyName = 'user_name';
  static const _keyEmail = 'user_email';

  static Future<void> setUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyImagePath, user.imagePath);
    await prefs.setString(_keyName, user.name);
    await prefs.setString(_keyEmail, user.email);
  }

  static Future<User> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final imagePath = prefs.getString(_keyImagePath) ?? '';
    final name = prefs.getString(_keyName) ?? '';
    final email = prefs.getString(_keyEmail) ?? '';

    return User(imagePath: imagePath, name: name, email: email);
  }

  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyImagePath);
    await prefs.remove(_keyName);
    await prefs.remove(_keyEmail);
  }

  static Future<void> setUserName(String userName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyName, userName);
  }

  static Future<String> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyName) ?? '';
  }

  static Future<Uint8List?> pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);

    if (_file != null) {
      return await _file.readAsBytes();
    }
    print("no image :'(");
    return null;
  }
}
