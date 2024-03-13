import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth extends ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;
  bool isEqual = false;
  bool isVisible = false;

  Future<void> signUp(String email, String password) async {
    Uri url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDHbS279TE1vD_P7X6L5ebG4KLtCpV3OR4');
    final response = await http.post(
      url,
      body: json.encode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );
    print(json.decode(response.body));
  }

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
