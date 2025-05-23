import 'package:get/get.dart';
import 'package:truck_track/app/models/pesanan.dart';
import 'package:truck_track/service_locator.dart';
import 'package:truck_track/services/delivery_service.dart';

class SettingDeliveryController extends GetxController {
  final listDeliverys = <Pesanan>[].obs;

  final deliveryService = sl<DeliveryService>();

  @override
  Future<void> onInit() async {
    super.onInit();

    final users = await deliveryService.getPesanan();
    listDeliverys.assignAll(users);
  }
}
