import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:truck_track/app/controllers/auth_controller.dart';
import 'package:truck_track/service_locator.dart';
import 'package:truck_track/services/auth_service.dart';

class LoginController extends GetxController {
  final authService = sl<AuthService>();
  final authController = Get.find<AuthController>();

  @override
  Future<void> onInit() async {
    super.onInit();

    await Future.delayed(const Duration(seconds: 2), () {
      debugPrint(
        'LoginController initialized: ${authService.currentUser?.name}',
      );

      // Gunakan nilai dari AuthController untuk memastikan konsistensi
      final user = authService.currentUser;
      if (authService.isLoggedIn && user != null) {
        authController.user.value = user;
        Get.offAllNamed('/home');
      }
    });
  }
}
