import 'dart:convert';
import 'package:chat_app_flutter/core/common/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDataSource {
  final SharedPreferences _preferences;

  AuthLocalDataSource({
    required SharedPreferences preferences,
  }) : _preferences = preferences;

  // Lưu thông tin người dùng và accessToken vào SharedPreferences
  Future<bool> setUserLoggedIn(User user, String accessToken) async {
    // Chuyển đổi đối tượng User thành JSON và lưu cùng với accessToken
    final userJson = jsonEncode({
      'user': user.toJson(),
      'accessToken': accessToken,
    });
    return _preferences.setString('authUser', userJson);
  }

  // Lấy thông tin người dùng từ SharedPreferences
  User? getUserLoggedIn() {
    final userJson = _preferences.getString('authUser');
    if (userJson == null) {
      return null;
    }

    final Map<String, dynamic> jsonMap = jsonDecode(userJson);
    return User.fromJson(jsonMap['user']);
  }

  // Lấy accessToken từ SharedPreferences
  String? getAccessToken() {
    final userJson = _preferences.getString('authUser');
    if (userJson == null) {
      return null;
    }

    final Map<String, dynamic> jsonMap = jsonDecode(userJson);
    return jsonMap['accessToken'] as String?;
  }

  // Xóa thông tin người dùng và accessToken khỏi SharedPreferences
  Future<bool> clearUser() {
    return _preferences.remove('authUser');
  }
}
