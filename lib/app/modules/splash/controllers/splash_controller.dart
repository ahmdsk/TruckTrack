import 'package:get/get.dart';
import 'package:truck_track/service_locator.dart';
import 'package:truck_track/services/auth_service.dart';

class SplashController extends GetxController {
  final authService = sl<AuthService>();

  @override
  void onInit() {
    super.onInit();
    print('SplashController initialized');

    // Simulate a delay for splash screen
    Future.delayed(const Duration(seconds: 2), () {
      Future.microtask(() => checkToken());
    });
  }

  void checkToken() async {
    await authService.loadUser();

    if (authService.isLoggedIn && authService.currentUser != null) {
      Get.offAllNamed('/home');
    } else {
      Get.offAllNamed('/login');
    }
  }
}
