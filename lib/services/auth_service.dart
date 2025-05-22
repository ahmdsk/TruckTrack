import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truck_track/app/models/user.dart';
import 'package:truck_track/app/routes/app_pages.dart';
import 'package:truck_track/components/snackbar.dart';

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
            debugPrint('Token Kamu Expired, Silahkan Login Kembali');
            // await logout();

            showCustomSnackbar(title: 'Token Expired', message: 'Token Kamu Expired, Silahkan Login Kembali');
            await logout();

            Get.offAllNamed(Routes.LOGIN);
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

    // Clear current user
    _currentUser = null;
  }

  bool get isLoggedIn => prefs.getString('access_token') != null;
}
