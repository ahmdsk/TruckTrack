import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:truck_track/app/models/kendaraan.dart';
import 'package:truck_track/app/models/user.dart';
import 'package:truck_track/components/snackbar.dart';
import 'package:truck_track/service_locator.dart';
import 'package:truck_track/services/kendaraan_service.dart';
import 'package:truck_track/services/user_service.dart';

class MasterDataKendaraanController extends GetxController {
  final listKendaraan = <Kendaraan>[].obs;
  final listDrivers = <User>[].obs;

  final kendaraanService = sl<KendaraanService>();
  final userService = sl<UserService>();

  // Di dalam MasterDataKendaraanController
  final selectedDriver = Rxn<User>();
  final noPolisiController = TextEditingController();
  final jenisKendaraanController = TextEditingController();
  final kapasitasTangkiController = TextEditingController();
  final noSegelController = TextEditingController();

  @override
  Future<void> onInit() async {
    super.onInit();

    // Ambil data kendaraan
    final kendaraan = await kendaraanService.getKendaraan();
    listKendaraan.assignAll(kendaraan);

    // Ambil data driver dari user_service
    final users = await userService.getAllByRoles(UserRole.driver);
    listDrivers.assignAll(users);
  }

  // Method untuk submit data ke API
  Future<void> addKendaraan() async {
    final newKendaraan = {
      'id_driver': selectedDriver.value?.id,
      'no_polisi': noPolisiController.text,
      'jenis_kendaraan': jenisKendaraanController.text,
      'kapasitas_tangki': kapasitasTangkiController.text,
      'no_segel': noSegelController.text,
    };

    await kendaraanService.addKendaraan(newKendaraan);
    Get.back(); // tutup modal/bottomsheet
    showCustomSnackbar(
      title: 'Sukses',
      message: 'Kendaraan berhasil ditambahkan',
    );
    // refresh list
    final kendaraan = await kendaraanService.getKendaraan();
    listKendaraan.assignAll(kendaraan);
  }

  // Method untuk menghapus kendaraan
  Future<void> deleteKendaraan(int id) async {
    await kendaraanService.deleteKendaraan(id.toString());
    showCustomSnackbar(title: 'Sukses', message: 'Kendaraan berhasil dihapus');

    // refresh list
    final kendaraan = await kendaraanService.getKendaraan();
    listKendaraan.assignAll(kendaraan);

    // Clear semua controller
    clearForm();
  }

  // Method untuk mengupdate kendaraan
  Future<void> updateKendaraan(int id) async {
    final updatedKendaraan = {
      'id_driver': selectedDriver.value?.id,
      'no_polisi': noPolisiController.text,
      'jenis_kendaraan': jenisKendaraanController.text,
      'kapasitas_tangki': kapasitasTangkiController.text,
      'no_segel': noSegelController.text,
    };

    await kendaraanService.updateKendaraan(id.toString(), updatedKendaraan);
    Get.back(); // tutup modal/bottomsheet
    showCustomSnackbar(title: 'Sukses', message: 'Kendaraan berhasil diupdate');

    // refresh list
    final kendaraan = await kendaraanService.getKendaraan();
    listKendaraan.assignAll(kendaraan);

    // Clear semua controller
    clearForm();
  }

  void clearForm() {
    selectedDriver.value = null;
    noPolisiController.clear();
    jenisKendaraanController.clear();
    kapasitasTangkiController.clear();
    noSegelController.clear();
  }
}
