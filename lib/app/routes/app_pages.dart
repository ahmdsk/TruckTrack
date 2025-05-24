import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/maps/bindings/maps_binding.dart';
import '../modules/maps/views/maps_view.dart';
import '../modules/master_data/kendaraan/bindings/master_data_kendaraan_binding.dart';
import '../modules/master_data/kendaraan/views/master_data_kendaraan_view.dart';
import '../modules/master_data/pengguna/bindings/master_data_pengguna_binding.dart';
import '../modules/master_data/pengguna/views/master_data_pengguna_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/setting_delivery/bindings/setting_delivery_binding.dart';
import '../modules/setting_delivery/views/setting_delivery_view.dart';
import '../modules/setting_order/bindings/setting_order_binding.dart';
import '../modules/setting_order/views/setting_order_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.MAPS,
      page: () => const MapsView(),
      binding: MapsBinding(),
    ),
    GetPage(
      name: _Paths.MASTER_DATA_KENDARAAN,
      page: () => const MasterDataKendaraanView(),
      binding: MasterDataKendaraanBinding(),
    ),
    GetPage(
      name: _Paths.MASTER_DATA_PENGGUNA,
      page: () => const MasterDataPenggunaView(),
      binding: MasterDataPenggunaBinding(),
    ),
    GetPage(
      name: _Paths.SETTING_DELIVERY,
      page: () => const SettingDeliveryView(),
      binding: SettingDeliveryBinding(),
    ),
    GetPage(
      name: _Paths.SETTING_ORDER,
      page: () => const SettingOrderView(),
      binding: SettingOrderBinding(),
    ),
  ];
}
