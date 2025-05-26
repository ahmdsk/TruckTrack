import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truck_track/app/data/api_client.dart';
import 'package:truck_track/app/models/user.dart';

class AuthService {
  final SharedPreferences prefs;

  AuthService(this.prefs);

  final Rxn<User> _user = Rxn<User>();
  User? get currentUser => _user.value;

  String? _accessToken;

  void setupInterceptor(VoidCallback onUnauthorized) {
    ApiClient.dio.interceptors.add(
      InterceptorsWrapper(
        onError: (e, handler) async {
          if (e.response?.statusCode == 401) {
            await logout();
            onUnauthorized();
          }
          return handler.next(e);
        },
      ),
    );
  }

  Future<void> loadFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    _accessToken = prefs.getString('access_token');
    final userJson = prefs.getString('user');
    if (_accessToken != null) {
      ApiClient.setToken(_accessToken!);
    }
    if (userJson != null) {
      _user.value = User.fromJson(jsonDecode(userJson));
    }
  }  

  Future<bool> login(String email, String pass) async {
    try {
      final res = await ApiClient.post(
        '/login',
        data: {'email': email, 'password': pass},
      );

      final token = res?.data['token'];
      final userJson = res?.data['user'];

      await prefs.setString('access_token', token);
      await prefs.setString('user', jsonEncode(userJson));

      ApiClient.dio.options.headers['Authorization'] = 'Bearer $token';

      _user.value = User.fromJson(userJson);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<User?> loadUser() async {
    final userStr = prefs.getString('user');
    if (userStr != null) {
      return User.fromJson(jsonDecode(userStr));
    }
    return null;
  }

  Future<void> logout() async {
    await prefs.clear();
    ApiClient.dio.options.headers.remove('Authorization');

    _user.value = null;
  }

  bool get isLoggedIn => prefs.getString('access_token') != null;
}
