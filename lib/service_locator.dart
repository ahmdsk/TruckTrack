import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truck_track/app/data/api_client.dart';
import 'package:truck_track/services/delivery_service.dart';
import 'package:truck_track/services/jadwal_pengiriman_service.dart';
import 'package:truck_track/services/kendaraan_service.dart';
import 'package:truck_track/services/order_service.dart';
import 'package:truck_track/services/user_service.dart';
import 'services/auth_service.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {
  // Register SharedPreferences (async singleton)
  final prefs = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(prefs);
  sl.registerSingleton<Dio>(ApiClient.dio);

  // Register AuthService (custom service wrapper)
  sl.registerSingleton<AuthService>(AuthService(sl())); // dio & prefs
  sl.registerSingleton<KendaraanService>(KendaraanService());
  sl.registerSingleton<UserService>(UserService());
  sl.registerSingleton<DeliveryService>(DeliveryService());
  sl.registerSingleton<OrderService>(OrderService());
  sl.registerSingleton<JadwalPengirimanService>(JadwalPengirimanService());
}
