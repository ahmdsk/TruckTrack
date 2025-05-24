import 'package:get/get.dart';
import 'package:truck_track/app/models/tujuan_kirim.dart';
import 'package:truck_track/service_locator.dart';
import 'package:truck_track/services/delivery_service.dart';

class SettingDeliveryController extends GetxController {
  final listDelivery = <TujuanKirim>[].obs;

  // Service
  final deliveryService = sl<DeliveryService>();

  @override
  Future<void> onInit() async {
    super.onInit();

    // Get parameter if needed
    final String? id = Get.parameters['orderId'];

    final deliverys = await deliveryService.getDelivery(orderId: id!);
    listDelivery.assignAll(deliverys);
  }
}
