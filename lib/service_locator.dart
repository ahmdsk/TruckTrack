import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'services/auth_service.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {
  // Register SharedPreferences (async singleton)
  final prefs = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(prefs);

  // Register Dio
  final dio = Dio(BaseOptions(
    baseUrl: 'http://127.0.0.1:8000/api',
    headers: {'Content-Type': 'application/json'},
  ));

  sl.registerSingleton<Dio>(dio);

  // Register AuthService (custom service wrapper)
  sl.registerSingleton<AuthService>(AuthService(sl(), sl())); // dio & prefs
}
