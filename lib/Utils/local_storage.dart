import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static final LocalStorage instance = LocalStorage._internal();

  factory LocalStorage() {
    return instance;
  }

  LocalStorage._internal();

  SharedPreferences? _preferencesInstance;
  final String _verificationToken = "verificationToken";

  SharedPreferences get prefs {
    if (_preferencesInstance == null) {
      throw ("Call LocalStorage.init() to initialize local storage");
    }
    return _preferencesInstance!;
  }

  Future<void> init() async {
    _preferencesInstance = await SharedPreferences.getInstance();
    await initData();
  }

  Future<void> initData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
  }

  //Get

  String getVerificationToken() {
    String stringValue = prefs.getString(_verificationToken) ?? "";
    return stringValue;
  }


  // Set

  Future<bool> setVerificationToken(String? s) async {
    return prefs.setString(_verificationToken, s ?? "");
  }

  //
  // clearData() async {
  //   await  prefs.clear();
  //   Session.accessToken = '';
  // }
}
