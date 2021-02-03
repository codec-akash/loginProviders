import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:loginProvider/api/api_call.dart';
import 'package:loginProvider/model/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String _token;
  String organizationId;
  LoginPageModel loginPageModel;

  bool get isAuth {
    return _token != null;
  }

  String get token {
    if (_token != null) {
      return _token;
    }
    return null;
  }

  Future<void> login(String email, String password) async {
    final url = 'user/login';
    print("reached");
    Map<String, dynamic> payload = {
      "email": email,
      "password": password,
    };
    try {
      Map<String, dynamic> response = await ApiCall().postNoAuth(url, payload);
      if (response["error"] != null) {
        print(response["error"]);
        // ----- Throw Exception.
        throw response["error"];
      } else {
        loginPageModel = LoginPageModel.fromJson(response['result']);
        print(loginPageModel.organizationId);
        _token = loginPageModel.xAuthToken;
        notifyListeners();

        final prefs = await SharedPreferences.getInstance();
        final userData = json.encode({'_token': _token});
        prefs.setString('user_token', userData);
        // throw "Organization id - ${loginPageModel.organizationId}";
      }
    } catch (e) {
      throw e;
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('user_token')) {
      return false;
    }
    final extractedData =
        json.decode(prefs.getString('user_token')) as Map<String, Object>;

    _token = extractedData['_token'];
    notifyListeners();

    return true;
  }

  Future<void> logout() async {
    _token = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
