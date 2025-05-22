import 'package:get/get.dart';
import 'package:truck_track/app/models/kendaraan.dart';
import 'package:truck_track/service_locator.dart';
import 'package:truck_track/services/kendaraan_service.dart';

class MasterDataKendaraanController extends GetxController {
  final listKendaraan = <Kendaraan>[].obs;

  final kendaraanService = sl<KendaraanService>();

  @override
  Future<void> onInit() async {
    super.onInit();

    final kendaraan = await kendaraanService.getKendaraan();
    listKendaraan.assignAll(kendaraan);
  }
}
