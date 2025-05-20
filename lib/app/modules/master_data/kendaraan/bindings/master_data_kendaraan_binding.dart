import 'package:get/get.dart';

import '../controllers/master_data_kendaraan_controller.dart';

class MasterDataKendaraanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MasterDataKendaraanController>(
      () => MasterDataKendaraanController(),
    );
  }
}
