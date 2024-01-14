
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class RatingModel extends ChangeNotifier {
  late int _number;

  int get number => _number;
 void updateData(int newData) {
    _number = newData;
    notifyListeners();
  }
}
