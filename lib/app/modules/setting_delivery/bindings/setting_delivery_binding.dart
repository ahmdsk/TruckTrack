import 'package:get/get.dart';

import '../controllers/setting_delivery_controller.dart';

class SettingDeliveryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingDeliveryController>(
      () => SettingDeliveryController(),
    );
  }
}
