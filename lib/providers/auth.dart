import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopin/models/http_exception.dart';

class Auth extends ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;
  bool isEqual = false;
  bool isVisible = false;

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    Uri url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/$urlSegment?key=AIzaSyDHbS279TE1vD_P7X6L5ebG4KLtCpV3OR4');

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(message: responseData['error']['message']);
      }
      print(json.decode(response.body));
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<void> signUp(String email, String password) async {
    return _authenticate(email, password, 'accounts:signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'accounts:signInWithPassword');
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
