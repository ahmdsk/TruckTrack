import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truck_track/app/models/user.dart';

class AuthService {
  final Dio dio;
  final SharedPreferences prefs;

  User? _currentUser;
  User? get currentUser => _currentUser;

  AuthService(this.dio, this.prefs) {
    _setupInterceptor();

    final userStr = prefs.getString('user');
    if (userStr != null) {
      _currentUser = User.fromJson(jsonDecode(userStr));
    }
  }

  void _setupInterceptor() {
    dio.interceptors.clear(); // optional
    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (e, handler) async {
          if (e.response?.statusCode == 401 || currentUser == null) {
            final success = await refreshToken();
            if (success) {
              final retry = e.requestOptions;
              retry.headers['Authorization'] =
                  'Bearer ${prefs.getString('access_token')}';
              final res = await dio.fetch(retry);
              return handler.resolve(res);
            }
          }
          return handler.next(e);
        },
      ),
    );

    final token = prefs.getString('access_token');
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }
  }

  Future<bool> refreshToken() async {
    final refresh = prefs.getString('refresh_token');
    if (refresh == null) return false;

    try {
      final res = await dio.post('/refresh');
      final newAccess = res.data['token'];

      await prefs.setString('access_token', newAccess);

      dio.options.headers['Authorization'] = 'Bearer $newAccess';
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> login(String email, String pass) async {
    try {
      final res = await dio.post(
        '/login',
        data: {'email': email, 'password': pass},
      );

      final token = res.data['token'];
      final userJson = res.data['user'];

      await prefs.setString('access_token', token);
      await prefs.setString('user', jsonEncode(userJson));

      _currentUser = User.fromJson(userJson);

      dio.options.headers['Authorization'] = 'Bearer $token';
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
  }

  bool get isLoggedIn => prefs.getString('access_token') != null;
}
