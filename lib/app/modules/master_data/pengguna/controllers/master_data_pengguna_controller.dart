import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:truck_track/app/models/user.dart';
import 'package:truck_track/components/snackbar.dart';
import 'package:truck_track/service_locator.dart';
import 'package:truck_track/services/user_service.dart';

class MasterDataPenggunaController extends GetxController {
  final listUsers = <User>[].obs;

  final userService = sl<UserService>();

  // Di dalam MasterDataPenggunaController
  final selectedRole = Rxn<String>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final noSimController = TextEditingController();
  final noTelpController = TextEditingController();
  final alamatController = TextEditingController();

  final roleOptions = [
    'manager',
    'driver',
    'costumer',
  ];

  @override
  Future<void> onInit() async {
    super.onInit();

    final users = await userService.getAllUsers();
    listUsers.assignAll(users);
  }

  // Method untuk submit data ke API
  Future<void> addUser() async {
    final newUser = {
      'name': nameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'role': selectedRole.value,
      'no_sim': noSimController.text, // Tambahkan no_sim jika diperlukan
      'no_telp': noTelpController.text, // Tambahkan no_telp jika diperlukan
      'alamat': alamatController.text // Tambahkan alamat jika diperlukan
    };

    await userService.addUser(newUser);
    Get.back(); // tutup modal/bottomsheet
    showCustomSnackbar(
      title: 'Sukses',
      message: 'Pengguna berhasil ditambahkan',
    );
    // refresh list
    final users = await userService.getAllUsers();
    listUsers.assignAll(users);

    // Clear semua controller
    clearForm();
  }

  // Method untuk menghapus pengguna
  Future<void> deleteUser(int? id) async {
    await userService.deleteUser(id.toString());
    showCustomSnackbar(
      title: 'Sukses',
      message: 'Pengguna berhasil dihapus',
    );
    // refresh list
    final users = await userService.getAllUsers();
    listUsers.assignAll(users);
  }

  // Method untuk mengupdate pengguna
  Future<void> updateUser(String id) async {
    final updatedUser = {
      'name': nameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'role': selectedRole.value,
      'no_sim': noSimController.text, // Tambahkan no_sim jika diperlukan
      'no_telp': noTelpController.text, // Tambahkan no_telp jika diperlukan
      'alamat': alamatController.text // Tambahkan alamat jika diperlukan
    };

    await userService.updateUser(id, updatedUser);
    Get.back(); // tutup modal/bottomsheet
    showCustomSnackbar(
      title: 'Sukses',
      message: 'Pengguna berhasil diupdate',
    );
    // refresh list
    final users = await userService.getAllUsers();
    listUsers.assignAll(users);

    // Clear semua controller
    clearForm();
  }

  // Method untuk clear semua controller
  void clearForm() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    selectedRole.value = null;
  }
}
