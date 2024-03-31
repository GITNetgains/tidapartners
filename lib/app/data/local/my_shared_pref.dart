// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:shared_preferences/shared_preferences.dart';

class MySharedPref {
  // prevent making instance
  MySharedPref._();

  // get storage
  static late SharedPreferences _sharedPreferences;

  // STORING KEYS
  static const String _fcmTokenKey = 'fcm_token';
  static const String _longi = "longi";
  static const String _lati = "lati";
  static const String _userId = "userId";
  static const String _token = "token";
  static const String _refToken = "refToken";
  static const String _name = "_name";
  static const String _email = "email";
  static const String _city = "city";
  static const String _phone = "phone";
  static const String _avatar = "avatar";

  /// init get storage services
  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  /// set theme current type as light theme
  static void setName(String name) => _sharedPreferences.setString(_name, name);

  static String getName() => _sharedPreferences.getString(_name) ?? "";

  /// set theme current type as light theme
  static void setEmail(String email) =>
      _sharedPreferences.setString(_email, email);

  static String getEmail() => _sharedPreferences.getString(_email) ?? "";

  static void setlati(String lati) => _sharedPreferences.setString(_lati, lati);

  static String? getlati() => _sharedPreferences.getString(_lati) ?? "";

  static void setlongi(String longi) =>
      _sharedPreferences.setString(_longi, longi);

  static String? getlongi() => _sharedPreferences.getString(_longi) ?? "";

  static void setcity(String city) => _sharedPreferences.setString(_city, city);

  static String? getcity() => _sharedPreferences.getString(_city) ?? "";

  /// save generated fcm token
  static void setFcmToken(String token) =>
      _sharedPreferences.setString(_fcmTokenKey, token);

  /// get generated fcm token
  static String? getFcmToken() => _sharedPreferences.getString(_fcmTokenKey);

  //Userid getter setter
  static void setUserId(String userId) =>
      _sharedPreferences.setString(_userId, userId);

  static String? getUserId() => _sharedPreferences.getString(_userId);

  //Token getter setter
  static void setToken(String accessToken) =>
      _sharedPreferences.setString(_token, accessToken);

  static String? getToken() => _sharedPreferences.getString(_token);

  //Refresh Token getter setter
  static void setRefreshToken(String refToken) =>
      _sharedPreferences.setString(_refToken, refToken);

  static String? getRefreshToken() => _sharedPreferences.getString(_refToken);

  static void setPhone(String phone) =>
      _sharedPreferences.setString(_phone, phone);

  static String? getPhone() => _sharedPreferences.getString(_phone);

  static void setAvatar(String avatar) =>
      _sharedPreferences.setString(_avatar, avatar);

  static String? getAvatar() => _sharedPreferences.getString(_avatar);

  static void clearSession() {
    _sharedPreferences.clear();
  }
}
