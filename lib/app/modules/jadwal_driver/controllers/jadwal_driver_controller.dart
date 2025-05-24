import 'package:get/get.dart';
import 'package:truck_track/app/models/jadwal_pengiriman_driver.dart';
import 'package:truck_track/service_locator.dart';
import 'package:truck_track/services/jadwal_pengiriman_service.dart';

class JadwalDriverController extends GetxController {
  final jadwalPengirimanService = sl<JadwalPengirimanService>();

  final listJadwalPengirimanDrivers = <JadwalPengirimanDriver>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    final jadwalPengiriman =
        await jadwalPengirimanService.getJadwalPengirimanDriver();
    listJadwalPengirimanDrivers.assignAll(jadwalPengiriman);
  }

  Future<void> startDelivery(String idPesanan) async {
    await jadwalPengirimanService.startDelivery(idPesanan);
    
    final jadwalPengiriman = await jadwalPengirimanService.getJadwalPengirimanDriver();
    listJadwalPengirimanDrivers.assignAll(jadwalPengiriman);
  }
}
