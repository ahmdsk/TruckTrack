import 'package:get/get.dart';

import '../controllers/jadwal_driver_controller.dart';

class JadwalDriverBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JadwalDriverController>(
      () => JadwalDriverController(),
    );
  }
}
