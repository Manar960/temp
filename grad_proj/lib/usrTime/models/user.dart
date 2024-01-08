class UserData {
  String userName;

  UserData({
    required this.userName,
  });
}

class AuthProvider {
  static UserData? _userData;

  static UserData? get userData => _userData;

  static void setUserData(UserData data) {
    _userData = data;
  }
}
