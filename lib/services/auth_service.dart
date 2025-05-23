import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:truck_track/app/data/api_client.dart';
import 'package:truck_track/app/models/user.dart';

class AuthService {
  final SharedPreferences prefs;

  User? _currentUser;
  User? get currentUser => _currentUser;

  AuthService(this.prefs) {
    final userStr = prefs.getString('user');
    if (userStr != null) {
      _currentUser = User.fromJson(jsonDecode(userStr));
    }
  }

  Future<bool> login(String email, String pass) async {
    try {
      final res = await ApiClient.post(
        '/login',
        data: {'email': email, 'password': pass},
      );

      final token = res!.data['token'];
      final userJson = res.data['user'];

      await prefs.setString('access_token', token);
      await prefs.setString('user', jsonEncode(userJson));

      _currentUser = User.fromJson(userJson);

      ApiClient.dio.options.headers['Authorization'] = 'Bearer $token';
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> loadUser() async {
    final userStr = prefs.getString('user');
    if (userStr != null) {
      _currentUser = User.fromJson(jsonDecode(userStr));
    }
  }

  Future<void> logout() async {
    await prefs.clear();

    // Clear current user
    _currentUser = null;
  }

  bool get isLoggedIn => prefs.getString('access_token') != null;
}
