import 'package:get/get.dart';
import 'package:truck_track/app/controllers/auth_controller.dart';

import '../controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(
      () => SplashController(),
    );
    Get.lazyPut<AuthController>(
      () => AuthController(),
    );
  }
}
