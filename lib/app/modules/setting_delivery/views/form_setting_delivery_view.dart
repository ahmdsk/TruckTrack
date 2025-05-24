import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:truck_track/app/models/tujuan_kirim.dart';

import 'package:truck_track/app/modules/setting_delivery/controllers/setting_delivery_controller.dart';
import 'package:truck_track/components/button.dart';
import 'package:truck_track/components/search_field_with_dropdown.dart';
import 'package:truck_track/core/themes/themes.dart';

class FormSettingDeliveryView extends GetView<SettingDeliveryController> {
  const FormSettingDeliveryView({super.key});

  @override
  Widget build(BuildContext context) {
    final c = controller;
    final TujuanKirim? tujuanKirim = Get.arguments;

    debugPrint('FormSettingDeliveryView: ${Get.arguments}');

    // Jika tujuanKirim tidak null, set nilai controller dari tujuanKirim
    if (tujuanKirim != null) {
      // Set initial values from tujuanKirim
      c.asalController.text = tujuanKirim.alamatAsal;
      c.tujuanController.text = tujuanKirim.alamatTujuan;
      c.latAsal.value = tujuanKirim.latitudeAsal;
      c.longAsal.value = tujuanKirim.longitudeAsal;
      c.latTujuan.value = tujuanKirim.latitudeTujuan;
      c.longTujuan.value = tujuanKirim.longitudeTujuan;
      c.jarak.value = tujuanKirim.jarak ?? '-';
      c.waktu.value = tujuanKirim.waktuTempuh ?? '-';
      c.catatan.text = tujuanKirim.catatan ?? '-';
      c.alamatAsal.value = tujuanKirim.alamatAsal;
      c.alamatTujuan.value = tujuanKirim.alamatTujuan;

      // Set initial search results to empty
      c.hasilAsal.value = [];
      c.hasilTujuan.value = [];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          tujuanKirim == null ? 'Tambah Tujuan Pengiriman' : 'Edit Tujuan Pengiriman',
          style: Themes.subTitleStyle.copyWith(
            color: Themes.darkColor,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Obx(
              () => SearchFieldWithDropdown(
                title: "Alamat Asal",
                controller: controller.asalController,
                suggestions:
                    controller.hasilAsal
                        .map<String>((e) => e['place_name'].toString())
                        .toList(),
                onChanged:
                    (val) => controller.handleDebouncedSearch(
                      value: val,
                      isAsal: true,
                    ),
                onSuggestionTap: (val) {
                  final selected = controller.hasilAsal.firstWhere(
                    (e) => e['place_name'] == val,
                    orElse: () => null,
                  );
                  if (selected != null) controller.pilihTempat(selected, true);
                },
              ),
            ),
            const SizedBox(height: 16),
            Obx(
              () => SearchFieldWithDropdown(
                title: "Alamat Tujuan",
                controller: controller.tujuanController,
                suggestions:
                    controller.hasilTujuan
                        .map<String>((e) => e['place_name'].toString())
                        .toList(),
                onChanged:
                    (val) => controller.handleDebouncedSearch(
                      value: val,
                      isAsal: false,
                    ),
                onSuggestionTap: (val) {
                  final selected = controller.hasilTujuan.firstWhere(
                    (e) => e['place_name'] == val,
                    orElse: () => null,
                  );
                  if (selected != null) controller.pilihTempat(selected, false);
                },
              ),
            ),
            const SizedBox(height: 16),
            Button(
              title: tujuanKirim == null ? 'Tambah' : 'Simpan',
              onPressed: () async {
                await c.hitungJarak();
                
                if (tujuanKirim == null) {
                  // Jika tujuanKirim null, berarti ini adalah penambahan baru
                  await c.kirimData();
                } else {
                  // Jika tujuanKirim tidak null, berarti ini adalah edit
                  await c.updateData(tujuanKirim.id);
                }
              },
            ),

            // UI untuk menampilkan jarak dan waktu clean
            const SizedBox(height: 16),
            Obx(
              () => Text(
                "Jarak: ${c.jarak.value} km, Waktu: ${c.waktu.value} menit",
                style: Themes.subTitleStyle.copyWith(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
