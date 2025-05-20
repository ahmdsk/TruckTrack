import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    print('SplashController initialized');

    // Simulate a delay for splash screen
    Future.delayed(const Duration(seconds: 2), () {
      // Navigate to the login page after the delay
      checkToken();
    });
  }

  void checkToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (token != null) {
      Get.offAllNamed('/home');
    } else {
      Get.offAllNamed('/login');
    }
  }
}
