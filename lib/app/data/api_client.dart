import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truck_track/components/snackbar.dart';

class ApiClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://api-truck.ladangku.my.id/api', // Ganti dengan base URL kamu
      // baseUrl: 'http://127.0.0.1:8000/api', // Ganti dengan base URL kamu
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');
    if (accessToken != null) {
      // dio.options.headers['Authorization'] = 'Bearer $accessToken';
      setToken(accessToken);
    }

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print("=== ON REQUEST ===");
          print('Method: ${options.method}');
          print('Path: ${options.uri}');
          return handler.next(options);
        },
        onError: (DioException error, handler) async {
          debugPrint('Ada Error DIO Nya: ${error.message}');

          if (error.response?.statusCode == 401) {
            final success = await _refreshToken();
            if (success) {
              // Retry original request
              final req = error.requestOptions;
              final retryResponse = await dio.fetch(req);
              return handler.resolve(retryResponse);
            }
          }
          return handler.next(error);
        },
      ),
    );

    print("Interceptor berhasil dipasang");
  }

  // Refresh Token
  static Future<bool> _refreshToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final refreshToken = prefs.getString('refresh_token');
      if (refreshToken == null) return false;

      final response = await ApiClient.post(
        '/refresh',
        data: {'refresh_token': refreshToken},
      );

      final newAccessToken = response!.data['token'];
      await setToken(newAccessToken);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Set Token
  static Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', token);
    dio.options.headers['Authorization'] = 'Bearer $token';
  }

  /// Fungsi umum GET
  static Future<Response?> get(
    String path, {
    Map<String, dynamic>? query,
  }) async {
    try {
      final response = await dio.get(path, queryParameters: query);
      return response;
    } on DioException catch (e) {
      _handleError(e);
      return null;
    }
  }

  /// Fungsi umum POST
  static Future<Response?> post(String path, {dynamic data}) async {
    try {
      final response = await dio.post(path, data: data);
      return response;
    } on DioException catch (e) {
      _handleError(e);
      return null;
    }
  }

  /// Fungsi umum PUT
  static Future<Response?> put(String path, {dynamic data}) async {
    try {
      final response = await dio.put(path, data: data);
      return response;
    } on DioException catch (e) {
      _handleError(e);
      return null;
    }
  }

  /// Fungsi umum DELETE
  static Future<Response?> delete(String path, {dynamic data}) async {
    try {
      final response = await dio.delete(path, data: data);
      return response;
    } on DioException catch (e) {
      _handleError(e);
      return null;
    }
  }

  /// Fungsi global penanganan error Dio
  static void _handleError(DioException e) {
    final status = e.response?.statusCode ?? 0;
    final message =
        e.response?.data['message'] ?? e.message ?? 'Terjadi kesalahan.';

    debugPrint("🛑 DioError [$status]: $message");
    showCustomSnackbar(title: "Gagal", message: message);
  }
}
