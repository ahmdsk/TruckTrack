import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:truck_track/app/modules/setting_delivery/controllers/setting_delivery_controller.dart';
import 'package:truck_track/components/search_field_with_dropdown.dart';

class FormSettingDeliveryView extends GetView<SettingDeliveryController> {
  const FormSettingDeliveryView({super.key});
  @override
  Widget build(BuildContext context) {
    final c = controller;

    return Scaffold(
      appBar: AppBar(title: const Text("Form Tujuan Kirim")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Obx(
              () => SearchFieldWithDropdown(
                title: "Alamat Asal",
                controller: controller.asalController,
                suggestions: controller.hasilAsal
                    .map<String>((e) => e['place_name'].toString())
                    .toList(),
                onChanged: (val) => controller.handleDebouncedSearch(
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
                suggestions: controller.hasilTujuan
                    .map<String>((e) => e['place_name'].toString())
                    .toList(),
                onChanged: (val) => controller.handleDebouncedSearch(
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
            TextField(
              controller: c.catatan,
              decoration: const InputDecoration(labelText: 'Catatan'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await c.hitungJarak();
                await c.kirimData();
              },
              child: const Text("Kirim"),
            ),
            Obx(() => Text("Jarak: ${c.jarak.value} km")),
            Obx(() => Text("Waktu: ${c.waktu.value} menit")),
          ],
        ),
      ),
    );
  }
}
