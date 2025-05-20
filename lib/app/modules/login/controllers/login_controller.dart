import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truck_track/app/modules/splash/controllers/splash_controller.dart';

class LoginController extends GetxController {
  SplashController splashController = Get.put(SplashController());

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  void setUserData(Map<String, dynamic> user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', user.toString());
    debugPrint('User data set: $user');
  }
}
