import 'package:flutter/foundation.dart';

class CompanyProvider with ChangeNotifier {
  String? _companyname;

  String? get username => _companyname;

  void setCompanyName(String name) {
    _companyname = name;
    notifyListeners();
  }
}
