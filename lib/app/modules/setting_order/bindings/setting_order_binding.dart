import 'package:get/get.dart';

import '../controllers/setting_order_controller.dart';

class SettingOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingOrderController>(
      () => SettingOrderController(),
    );
  }
}
