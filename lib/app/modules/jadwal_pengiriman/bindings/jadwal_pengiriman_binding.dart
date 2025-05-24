import 'package:get/get.dart';

import '../controllers/jadwal_pengiriman_controller.dart';

class JadwalPengirimanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JadwalPengirimanController>(
      () => JadwalPengirimanController(),
    );
  }
}
