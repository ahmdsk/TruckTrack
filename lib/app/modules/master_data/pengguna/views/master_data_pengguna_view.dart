import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'package:get/get.dart';
import 'package:truck_track/app/models/user.dart';
import 'package:truck_track/components/confirmation_dialog.dart';
import 'package:truck_track/components/dropdown.dart';
import 'package:truck_track/components/input.dart';
import 'package:truck_track/components/not_found_data.dart';
import 'package:truck_track/core/themes/themes.dart';

import '../controllers/master_data_pengguna_controller.dart';

class MasterDataPenggunaView extends GetView<MasterDataPenggunaController> {
  const MasterDataPenggunaView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kelola Pengguna',
          style: Themes.subTitleStyle.copyWith(
            color: Themes.darkColor,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.bottomSheet(
                isScrollControlled: true,
                Container(
                  height: Get.height * 0.8,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Themes.whiteColor,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: SingleChildScrollView(child: FormKelolaPengguna()),
                ),
              );
            },
            icon: Icon(FeatherIcons.plus, color: Themes.primaryColor),
          ),
        ],
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Obx(
          () =>
              controller.listUsers.isEmpty
                  ? const NotFoundData()
                  : ListView.builder(
                    itemCount: controller.listUsers.length,
                    itemBuilder: (context, index) {
                      return ItemListPengguna(
                        user: controller.listUsers[index],
                      );
                    },
                  ),
        ),
      ),
    );
  }
}

class ItemListPengguna extends StatelessWidget {
  const ItemListPengguna({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Themes.whiteColor,
        boxShadow: [
          BoxShadow(
            color: Themes.darkColor.withAlpha(20), // Lebih transparan
            blurRadius: 6, // Lebih menyebar
            spreadRadius: 1, // Menyebar tipis
            offset: const Offset(0, 2), // Lebih pendek bayangannya
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage('assets/images/profile-pict.jpg'),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name ?? '-',
                    style: Themes.titleStyle.copyWith(
                      color: Themes.primaryColor,
                      fontSize: 18,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    user.role.toString().toUpperCase(),
                    style: Themes.subTitleStyle.copyWith(
                      color: Themes.darkColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Get.bottomSheet(
                    isScrollControlled: true,
                    Container(
                      height: Get.height * 0.8,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Themes.whiteColor,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: FormKelolaPengguna(user: user),
                      ),
                    ),
                  );
                },
                icon: Icon(FeatherIcons.edit, color: Themes.primaryColor),
              ),
              IconButton(
                onPressed: () {
                  ConfirmationDialog.show(
                    title: 'Hapus Pengguna',
                    description:
                        'Apakah anda yakin ingin menghapus pengguna ini?',
                    onConfirm: () {
                      // Lanjutkan proses penghapusan di sini
                      final controller =
                          Get.find<MasterDataPenggunaController>();
                      controller.deleteUser(user.id);
                    },
                  );
                },
                icon: Icon(FeatherIcons.trash2, color: Themes.dangerColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FormKelolaPengguna extends StatelessWidget {
  const FormKelolaPengguna({super.key, this.user});

  final User? user;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MasterDataPenggunaController>();

    // isi form jika dalam mode edit
    if (user != null) {
      controller.nameController.text = user!.name ?? '';
      controller.emailController.text = user!.email ?? '';
      controller.selectedRole.value = user!.role ?? '';
      controller.noSimController.text = user!.noSim ?? '';
      controller.noTelpController.text = user!.noTelp ?? '';
      controller.alamatController.text = user!.alamat ?? '';
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          user != null ? 'Edit Pengguna' : 'Tambah Pengguna',
          style: Themes.titleStyle.copyWith(
            color: Themes.primaryColor,
            fontSize: 18,
          ),
        ),

        const SizedBox(height: 20),
        InputField(
          title: 'Nama Pengguna',
          hintText: 'Contoh: Jhon Doe',
          controller: controller.nameController,
        ),
        const SizedBox(height: 20),
        InputField(
          title: 'Email',
          hintText: 'Contoh: jhondoe@test.com',
          controller: controller.emailController,
        ),
        const SizedBox(height: 20),
        InputField(
          title: 'Password',
          hintText: 'Masukkan password',
          controller: controller.passwordController,
          isPassword: true,
        ),
        const SizedBox(height: 20),
        user?.role == 'driver'
            ? Column(
              children: [
                InputField(
                  title: 'No. SIM',
                  hintText: 'Contoh: 1234567890',
                  controller: controller.noSimController,
                ),
                const SizedBox(height: 20),
              ],
            )
            : const SizedBox.shrink(),
        Dropdown<String>(
          title: 'Pilih Role',
          hintText: 'Pilih salah satu role',
          value: controller.selectedRole.value,
          onChanged: (val) => controller.selectedRole.value = val,
          items:
              controller.roleOptions
                  .map(
                    (role) => DropdownMenuItem(value: role, child: Text(role)),
                  )
                  .toList(),
        ),
        const SizedBox(height: 20),
        InputField(
          title: 'No. Telp',
          hintText: 'Contoh: 081234567890',
          controller: controller.noTelpController,
        ),
        const SizedBox(height: 20),
        InputField(
          title: 'Alamat',
          hintText: 'Contoh: Jl. Raya No. 123, Jakarta',
          controller: controller.alamatController,
          largeText: true,
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: Get.width,
          child: ElevatedButton(
            onPressed: () {
              user != null
                  ? controller.updateUser(user!.id.toString())
                  : controller.addUser();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Themes.primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              user != null ? 'Update' : 'Simpan',
              style: Themes.bodyStyle.copyWith(
                color: Themes.whiteColor,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
