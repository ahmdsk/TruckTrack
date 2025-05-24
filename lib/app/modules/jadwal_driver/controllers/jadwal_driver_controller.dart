import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:truck_track/app/models/jadwal_pengiriman_driver.dart';
import 'package:truck_track/components/snackbar.dart';
import 'package:truck_track/service_locator.dart';
import 'package:truck_track/services/jadwal_pengiriman_service.dart';

class JadwalDriverController extends GetxController {
  final jadwalPengirimanService = sl<JadwalPengirimanService>();

  final listJadwalPengirimanDrivers = <JadwalPengirimanDriver>[].obs;

  final catatanController = TextEditingController();

  @override
  Future<void> onInit() async {
    super.onInit();

    final jadwalPengiriman =
        await jadwalPengirimanService.getJadwalPengirimanDriver();
    listJadwalPengirimanDrivers.assignAll(jadwalPengiriman);
  }

  Future<void> startDelivery(String idPesanan) async {
    await jadwalPengirimanService.startDelivery(idPesanan);

    showCustomSnackbar(title: 'Sukses', message: 'Pengiriman berhasil dimulai');

    final jadwalPengiriman = await jadwalPengirimanService.getJadwalPengirimanDriver();
    listJadwalPengirimanDrivers.assignAll(jadwalPengiriman);
  }

  Future<void> addDeliveryNote(String idPengiriman, String note) async {
    await jadwalPengirimanService.addDeliveryNote(idPengiriman, note);

    showCustomSnackbar(title: 'Sukses', message: 'Catatan pengiriman berhasil ditambahkan');
    
    final jadwalPengiriman = await jadwalPengirimanService.getJadwalPengirimanDriver();
    listJadwalPengirimanDrivers.assignAll(jadwalPengiriman);
  }

  Future<void> completeDelivery(String idPengiriman) async {
    await jadwalPengirimanService.completeDelivery(idPengiriman);

    showCustomSnackbar(title: 'Sukses', message: 'Pengiriman berhasil ditandai selesai');
    
    final jadwalPengiriman = await jadwalPengirimanService.getJadwalPengirimanDriver();
    listJadwalPengirimanDrivers.assignAll(jadwalPengiriman);
  }
}
