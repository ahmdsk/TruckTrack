import 'package:get/get.dart';

import '../controllers/maps_tracking_controller.dart';

class MapsTrackingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapsTrackingController>(
      () => MapsTrackingController(),
    );
  }
}
