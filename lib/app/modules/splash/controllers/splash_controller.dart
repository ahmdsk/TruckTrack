import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:truck_track/service_locator.dart';
import 'package:truck_track/services/auth_service.dart';

class SplashController extends GetxController {
  final authService = sl<AuthService>();

  @override
  void onInit() {
    super.onInit();

    // Simulate a delay for splash screen
    Future.delayed(const Duration(seconds: 2), () {
      Future.delayed(const Duration(seconds: 2), () async {
        await authService.loadFromStorage(); // <--- Tambahkan ini
        checkToken();
      });
    });
  }

  void checkToken() async {
    final user = authService.currentUser;
    debugPrint('SplashController initialized: $user');
    if (authService.isLoggedIn && user != null) {
      Get.offAllNamed('/home');
    } else {
      Get.offAllNamed('/login');
    }
  }
}
