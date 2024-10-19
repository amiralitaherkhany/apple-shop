import 'package:apple_shop/di/di.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthManager {
  static final ValueNotifier<String?> authChangeNotifier = ValueNotifier(null);
  static final SharedPreferences _sharedPref = locator.get();

  static void saveToken(String token) async {
    _sharedPref.setString('access_token', token);
    authChangeNotifier.value = token;
  }

  static void saveId(String id) async {
    _sharedPref.setString('user_id', id);
  }

  static void saveUserName(String userName) async {
    _sharedPref.setString('user_name', userName);
  }

  static String readAuth() {
    return _sharedPref.getString('access_token') ?? '';
  }

  static String getId() {
    return _sharedPref.getString('user_id') ?? '';
  }

  static String getUserName() {
    return _sharedPref.getString('user_name') ?? '';
  }

  static void logOut() {
    _sharedPref.clear();
    authChangeNotifier.value = null;
  }

  static bool isLogedIn() {
    String token = readAuth();
    return token.isNotEmpty;
  }
}
