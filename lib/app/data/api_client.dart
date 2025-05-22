import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truck_track/components/snackbar.dart';

class ApiClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'http://127.0.0.1:8000/api', // Ganti dengan base URL kamu
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
          // bisa tambah logging, atau token manual
          return handler.next(options);
        },
        onError: (DioException error, handler) async {
          showCustomSnackbar(title: 'Terjadi Kesalahan', message: error.message.toString());

          print('Ada Error DIO Nya: ${error.message}');

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
  }

  // Refresh Token
  static Future<bool> _refreshToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final refreshToken = prefs.getString('refresh_token');
      if (refreshToken == null) return false;

      final response = await dio.post(
        '/refresh',
        data: {'refresh_token': refreshToken},
      );

      final newAccessToken = response.data['access_token'];
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
}
