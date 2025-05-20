import 'package:get/get.dart';

import '../controllers/master_data_pengguna_controller.dart';

class MasterDataPenggunaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MasterDataPenggunaController>(
      () => MasterDataPenggunaController(),
    );
  }
}
