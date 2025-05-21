import 'package:get/get.dart';
import 'package:truck_track/service_locator.dart';
import 'package:truck_track/services/auth_service.dart';

class LoginController extends GetxController {
  final authService = sl<AuthService>();

  @override
  Future<void> onInit() async {
    super.onInit();

    Future.delayed(const Duration(seconds: 2), () {
      Future.microtask(() => {
        if (authService.isLoggedIn && authService.currentUser != null) {
          // If the user is already logged in, navigate to the home page
          Get.offAllNamed('/home')
        } else {
          // If not logged in, navigate to the login page
          Get.offAllNamed('/login')
        }
      });
    });
  }
}
