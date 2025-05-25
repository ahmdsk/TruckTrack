import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:truck_track/app/models/user.dart';
import 'package:truck_track/service_locator.dart';
import 'package:truck_track/services/auth_service.dart';

class AuthController extends GetxController {
  final AuthService authService = sl<AuthService>();

  final Rxn<User> user = Rxn<User>();

  User? get currentUser => user.value;
  bool get isLoggedIn => currentUser != null;

  @override
  Future<void> onInit() async {
    super.onInit();

    authService.setupInterceptor(() {
      logout();
      Get.offAllNamed('/login');
    });

    if (authService.isLoggedIn) {
      user.value = await authService.loadUser();
    }

    ever(user, (callback) {
      debugPrint('User changed: ${user.value?.name}');
    });
  }

  Future<void> login(String email, String password) async {
    final success = await authService.login(email, password);
    if (success) {
      user.value = await authService.loadUser();
      Get.offAllNamed('/home');
    } else {
      Get.snackbar('Login gagal', 'Email atau password salah');
    }
  }

  Future<void> logout() async {
    await authService.logout();
    user.value = null;
    Get.offAllNamed('/login');
  }
}
