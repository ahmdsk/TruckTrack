import 'package:get/get.dart';
import 'package:truck_track/app/models/cek_pesanan_costumer.dart';
import 'package:truck_track/components/snackbar.dart';
import 'package:truck_track/service_locator.dart';
import 'package:truck_track/services/order_service.dart';

class CekPesananController extends GetxController {
  final orderService = sl<OrderService>();

  final listPesananCostumers = <CekPesananCostumer>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    final jadwalPengiriman = await orderService.getCekPesananCostumer(
      Get.parameters['costumerId'] ?? '',
    );
    listPesananCostumers.assignAll(jadwalPengiriman);
  }

  Future<void> konfirmasiPesanan(String pesananId) async {
    await orderService.konfirmasiPesanan(pesananId);
    // Optionally, refresh the list after confirmation
    final jadwalPengiriman = await orderService.getCekPesananCostumer(
      Get.parameters['costumerId'] ?? '',
    );
    listPesananCostumers.assignAll(jadwalPengiriman);

    showCustomSnackbar(title: 'Berhasil', message: 'Pesanan telah dikonfirmasi');
  }
}
