import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truck_track/app/data/api_client.dart';
import 'package:truck_track/app/modules/login/controllers/login_controller.dart';
import 'package:truck_track/components/snackbar.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;

  LoginController loginController = Get.put(LoginController());

  Future<void> login(String email, String password) async {
    try {
      final response = await ApiClient.dio.post(
        '/login',
        data: {'email': email, 'password': password},
      );

      final accessToken = response.data['token'];
      final userData = response.data['user'];
      await ApiClient.setToken(accessToken);

      loginController.setUserData(userData);

      Get.offAllNamed('/home');
    } on DioException catch (e) {
      showCustomSnackbar(
        title: 'Login Failed',
        message: e.response?.data['message'] ?? 'Terjadi kesalahan',
      );
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    isLoggedIn.value = false;
    Get.offAllNamed('/login');
  }
}
