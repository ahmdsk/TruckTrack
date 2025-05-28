import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:truck_track/app/models/pesanan.dart';
import 'package:truck_track/app/models/user.dart';
import 'package:truck_track/components/snackbar.dart';
import 'package:truck_track/service_locator.dart';
import 'package:truck_track/services/order_service.dart';
import 'package:truck_track/services/user_service.dart';

class SettingOrderController extends GetxController {
  // List Driver dan Costumer
  final listDrivers = <User>[].obs;
  final listCostumers = <User>[].obs;

  final listOrders = <Pesanan>[].obs;

  // Panggil Services
  final orderService = sl<OrderService>();
  final userService = sl<UserService>();

  // Di dalam SettingDeliveryController
  final selectedDriver = Rxn<User>();
  final selectedCostumer = Rxn<User>();
  final noPesananController = TextEditingController();
  final jenisBBMController = TextEditingController();
  final volumeBBMController = TextEditingController();
  final alamatPengirimanController = TextEditingController();

  @override
  Future<void> onInit() async {
    super.onInit();

    final users = await orderService.getPesanan();
    listOrders.assignAll(users);

    // Ambil data driver dari user_service
    final drivers = await userService.getAllByRoles(UserRole.driver);
    listDrivers.assignAll(drivers);

    // Ambil data customer dari user_service
    final costumers = await userService.getAllByRoles(UserRole.costumer);
    listCostumers.assignAll(costumers);
  }

  // Method untuk submit data ke API
  Future<void> addPesanan() async {
    final newPesanan = {
      'driver_id': selectedDriver.value?.id,
      'costumer_id': selectedCostumer.value?.id,
      'no_pesanan': noPesananController.text,
      'jenis_bbm': jenisBBMController.text,
      'volume_bbm': volumeBBMController.text,
      'alamat_pengiriman': alamatPengirimanController.text,
    };

    await orderService.addPesanan(newPesanan);
    Get.back(); // tutup modal/bottomsheet
    // refresh list
    final pesanan = await orderService.getPesanan();
    listOrders.assignAll(pesanan);

    // Clear semua controller
    clearForm();
  }

  // Method untuk menghapus pesanan
  Future<void> deletePesanan(int id) async {
    await orderService.deletePesanan(id.toString());
    showCustomSnackbar(title: 'Sukses', message: 'Pesanan berhasil dihapus');

    // refresh list
    final pesanan = await orderService.getPesanan();
    listOrders.assignAll(pesanan);
  }

  // Method untuk clear semua controller
  void clearForm() {
    selectedDriver.value = null;
    selectedCostumer.value = null;
    noPesananController.clear();
    jenisBBMController.clear();
    volumeBBMController.clear();
    alamatPengirimanController.clear();
  }

  // Method untuk mengupdate pesanan
  Future<void> updatePesanan(int id) async {
    final updatedPesanan = {
      'driver_id': selectedDriver.value?.id,
      'costumer_id': selectedCostumer.value?.id,
      'no_pesanan': noPesananController.text,
      'jenis_bbm': jenisBBMController.text,
      'volume_bbm': volumeBBMController.text,
      'alamat_pengiriman': alamatPengirimanController.text,
    };

    await orderService.updatePesanan(id.toString(), updatedPesanan);
    Get.back(); // tutup modal/bottomsheet
    // refresh list
    final pesanan = await orderService.getPesanan();
    listOrders.assignAll(pesanan);

    // Clear semua controller
    clearForm();
  }
}
