import 'package:get/get.dart';
import 'package:truck_track/service_locator.dart';
import 'package:truck_track/services/auth_service.dart';

class AuthController extends GetxController {
  final AuthService authService = sl<AuthService>();

  Future<void> login(String email, String password) async {
    final success = await authService.login(email, password);
    if (success) {
      Get.offAllNamed('/home');
    } else {
      Get.snackbar('Login gagal', 'Email atau password salah');
    }
  }

  Future<void> logout() async {
    await authService.logout();
    Get.offAllNamed('/login');
  }

  bool get isLoggedIn => authService.isLoggedIn;
}
