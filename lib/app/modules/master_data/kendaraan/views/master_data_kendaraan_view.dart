import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'package:get/get.dart';
import 'package:truck_track/app/models/kendaraan.dart';
import 'package:truck_track/app/models/user.dart';
import 'package:truck_track/components/confirmation_dialog.dart';
import 'package:truck_track/components/dropdown.dart';
import 'package:truck_track/components/input.dart';
import 'package:truck_track/components/not_found_data.dart';
import 'package:truck_track/core/themes/themes.dart';

import '../controllers/master_data_kendaraan_controller.dart';

class MasterDataKendaraanView extends GetView<MasterDataKendaraanController> {
  const MasterDataKendaraanView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kelola Kendaraan',
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
                  child: SingleChildScrollView(child: FormKelolaKendaraan()),
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
              controller.listKendaraan.isEmpty
                  ? const NotFoundData()
                  : ListView.builder(
                    itemCount: controller.listKendaraan.length,
                    itemBuilder: (context, index) {
                      return ItemListKendaraan(
                        kendaraan: controller.listKendaraan[index],
                      );
                    },
                  ),
        ),
      ),
    );
  }
}

class FormKelolaKendaraan extends StatelessWidget {
  const FormKelolaKendaraan({super.key, this.kendaraan});

  final Kendaraan? kendaraan;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MasterDataKendaraanController>();

    // isi form jika dalam mode edit
    if (kendaraan != null) {
      controller.selectedDriver.value = controller.listDrivers.firstWhereOrNull(
        (e) => e.id == kendaraan!.idDriver,
      );
      controller.noPolisiController.text = kendaraan!.noPolisi;
      controller.jenisKendaraanController.text = kendaraan!.jenisKendaraan;
      
      controller.noSegelAtasController.text = kendaraan!.noSegelAtas;
      controller.noSegelBawahController.text = kendaraan!.noSegelBawah;
      controller.noSuratJalanController.text = kendaraan!.noSuratJalan;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          kendaraan != null ? 'Edit Kendaraan' : 'Tambah Kendaraan',
          style: Themes.titleStyle.copyWith(
            color: Themes.primaryColor,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 20),

        Obx(() {
          final drivers = controller.listDrivers;
          return Dropdown<User>(
            title: "Pilih Driver",
            hintText: "Pilih salah satu driver",
            value: controller.selectedDriver.value,
            onChanged: (val) => controller.selectedDriver.value = val,
            items:
                drivers
                    .map(
                      (driver) => DropdownMenuItem(
                        value: driver,
                        child: Text(driver.name ?? '-'),
                      ),
                    )
                    .toList(),
          );
        }),

        const SizedBox(height: 20),
        InputField(
          title: 'No Polisi',
          hintText: 'Contoh: B 1234 ABC',
          controller: controller.noPolisiController,
        ),
        const SizedBox(height: 20),
        InputField(
          title: 'Jenis Kendaraan',
          hintText: 'Contoh: Truck, Mobil Box',
          controller: controller.jenisKendaraanController,
        ),
        const SizedBox(height: 20),
        InputField(
          title: 'No. Segel Atas',
          hintText: 'Contoh: S1234567890',
          controller: controller.noSegelAtasController,
        ),
        const SizedBox(height: 20),
        InputField(
          title: 'No. Segel Bawah',
          hintText: 'Contoh: S0987654321',
          controller: controller.noSegelBawahController,
        ),
        const SizedBox(height: 20),
        InputField(
          title: 'No. Surat Jalan',
          hintText: 'Contoh: SJ1234567890',
          controller: controller.noSuratJalanController,
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: Get.width,
          child: ElevatedButton(
            onPressed: () {
              kendaraan != null
                  ? controller.updateKendaraan(kendaraan!.id)
                  : controller.addKendaraan();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Themes.primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              kendaraan != null ? 'Update' : 'Simpan',
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

class ItemListKendaraan extends StatelessWidget {
  const ItemListKendaraan({super.key, required this.kendaraan});

  final Kendaraan kendaraan;

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
                  backgroundImage: AssetImage('assets/images/truck-list.jpg'),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    kendaraan.jenisKendaraan,
                    style: Themes.titleStyle.copyWith(
                      color: Themes.primaryColor,
                      fontSize: 16,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    kendaraan.noPolisi,
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
                        child: FormKelolaKendaraan(kendaraan: kendaraan),
                      ),
                    ),
                  );
                },
                icon: Icon(FeatherIcons.edit, color: Themes.primaryColor),
              ),
              IconButton(
                onPressed: () {
                  ConfirmationDialog.show(
                    title: 'Hapus Kendaraan',
                    description:
                        'Apakah anda yakin ingin menghapus kendaraan ini?',
                    onConfirm: () {
                      // Lanjutkan proses penghapusan di sini
                      final controller =
                          Get.find<MasterDataKendaraanController>();
                      controller.deleteKendaraan(kendaraan.id);
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
