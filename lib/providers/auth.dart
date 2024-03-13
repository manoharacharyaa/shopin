import 'package:flutter/material.dart';

class Auth extends ChangeNotifier {
  bool isEqual = false;
  bool isVisible = false;

  void validator(String pass, String cnfPass) {
    if (pass == cnfPass) {
      isEqual = true;
    } else {
      isEqual = false;
    }
    notifyListeners();
  }

  void visible() {
    isVisible = !isVisible;
    notifyListeners();
  }
}
