import 'package:get/get.dart';
import 'package:truck_track/app/models/jadwal_pengiriman.dart';
import 'package:truck_track/service_locator.dart';
import 'package:truck_track/services/jadwal_pengiriman_service.dart';

class JadwalPengirimanController extends GetxController {
  final jadwalPengirimanService = sl<JadwalPengirimanService>();

  final listJadwalPengiriman = <JadwalPengiriman>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    final jadwalPengiriman = await jadwalPengirimanService.getAllJadwalPengiriman();
    listJadwalPengiriman.assignAll(jadwalPengiriman);
  }
}
