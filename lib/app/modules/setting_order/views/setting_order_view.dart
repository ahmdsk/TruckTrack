import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:truck_track/app/models/pesanan.dart';
import 'package:truck_track/app/models/user.dart';
import 'package:truck_track/components/confirmation_dialog.dart';
import 'package:truck_track/components/dropdown.dart';
import 'package:truck_track/components/input.dart';
import 'package:truck_track/components/not_found_data.dart';
import 'package:truck_track/core/themes/themes.dart';

import '../controllers/setting_order_controller.dart';

class SettingOrderView extends GetView<SettingOrderController> {
  const SettingOrderView({super.key});
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Atur Pesanan',
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
                  height: Get.height * 0.85,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Themes.whiteColor,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: SingleChildScrollView(child: FormKelolaDelivery()),
                ),
              );
            },
            icon: Icon(FeatherIcons.plus, color: Themes.primaryColor),
          ),
        ],
      ),
      body: Obx(
        () =>
            controller.listDeliverys.isEmpty
                ? const NotFoundData()
                : ListView.builder(
                  itemCount: controller.listDeliverys.length,
                  itemBuilder: (context, index) {
                    return PengirimanCard(
                      pesanan: controller.listDeliverys[index],
                    );
                  },
                ),
      ),
    );
  }
}

class PengirimanCard extends StatelessWidget {
  const PengirimanCard({super.key, required this.pesanan});

  final Pesanan pesanan;

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd MMM yyyy, HH:mm');

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Themes.darkColor.withAlpha(15),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: No Pesanan dan Tanggal
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  pesanan.noPesanan,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Themes.darkColor,
                  ),
                ),
                Text(
                  formatter.format(
                    DateTime.parse(pesanan.tanggalPesanan.toString()),
                  ),
                  style: TextStyle(
                    fontSize: 13,
                    color: Themes.darkColor.withAlpha(150),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Status
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: Themes.primaryColor.withAlpha(60),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                pesanan.statusPesanan.toUpperCase(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Themes.primaryColor,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Jenis dan Volume BBM
            Row(
              children: [
                Icon(
                  Icons.local_gas_station,
                  size: 18,
                  color: Themes.darkColor.withAlpha(120),
                ),
                SizedBox(width: 8),
                Text('${pesanan.jenisBbm} • ${pesanan.volumeBbm} Liter'),
              ],
            ),
            const SizedBox(height: 10),

            // Alamat
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 18,
                  color: Themes.darkColor.withAlpha(120),
                ),
                SizedBox(width: 8),
                Expanded(child: Text(pesanan.alamatPengiriman ?? '-')),
              ],
            ),
            const SizedBox(height: 10),

            // Driver dan Customer
            Row(
              children: [
                Icon(
                  Icons.person_outline,
                  size: 18,
                  color: Themes.darkColor.withAlpha(120),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Driver: ${pesanan.driver?.name ?? '-'} | Customer: ${pesanan.costumer?.name ?? '-'}',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 8,
              children: [
                Expanded(
                  child: _ActionButton(
                    label: 'Edit',
                    icon: Icons.edit,
                    color: Colors.blueAccent,
                    onTap: () {
                      debugPrint('Edit ${pesanan.noPesanan}');
                      Get.bottomSheet(
                        isScrollControlled: true,
                        Container(
                          height: Get.height * 0.85,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Themes.whiteColor,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          child: SingleChildScrollView(
                            child: FormKelolaDelivery(pesanan: pesanan),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: _ActionButton(
                    label: 'Hapus',
                    icon: Icons.delete,
                    color: Themes.dangerColor,
                    onTap: () {
                      ConfirmationDialog.show(
                        title: 'Hapus Pesanan',
                        description:
                            'Apakah anda yakin ingin menghapus pesanan ini?',
                        onConfirm: () {
                          // Lanjutkan proses penghapusan di sini
                          final controller =
                              Get.find<SettingOrderController>();
                          controller.deletePesanan(pesanan.id);
                        },
                      );
                    },
                  ),
                ),
                Expanded(
                  child: _ActionButton(
                    label: 'Atur',
                    icon: Icons.settings,
                    color: Themes.successColor,
                    onTap: () {
                      debugPrint('Atur ${pesanan.noPesanan}');
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FormKelolaDelivery extends StatelessWidget {
  const FormKelolaDelivery({super.key, this.pesanan});

  final Pesanan? pesanan;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SettingOrderController>();

    // isi form jika dalam mode edit
    if (pesanan != null) {
      controller.selectedDriver.value = controller.listDrivers.firstWhereOrNull(
        (e) => e.id == pesanan!.driverId,
      );
      controller.selectedCostumer.value = controller.listCostumers
          .firstWhereOrNull((e) => e.id == pesanan!.costumerId);
      controller.noPesananController.text = pesanan!.noPesanan;
      controller.jenisBBMController.text = pesanan!.jenisBbm;
      controller.volumeBBMController.text = pesanan!.volumeBbm.toString();
      controller.alamatPengirimanController.text =
          pesanan!.alamatPengiriman ?? '';
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          pesanan != null ? 'Edit Pesanan' : 'Tambah Pesanan',
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

        Obx(() {
          final costumer = controller.listCostumers;
          return Dropdown<User>(
            title: "Pilih Costumer",
            hintText: "Pilih salah satu costumer",
            value: controller.selectedCostumer.value,
            onChanged: (val) => controller.selectedCostumer.value = val,
            items:
                costumer
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
          title: 'No Pesanan',
          hintText: 'Contoh: P1234567890',
          controller: controller.noPesananController,
        ),
        const SizedBox(height: 20),
        InputField(
          title: 'Jenis BBM',
          hintText: 'Contoh: Solar, Pertalite',
          controller: controller.jenisBBMController,
        ),
        const SizedBox(height: 20),
        InputField(
          title: 'Volume BBM',
          hintText: 'Contoh: 1000',
          controller: controller.volumeBBMController,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 20),
        InputField(
          title: 'Alamat Pengiriman',
          hintText: 'Contoh: Jl. Raya No. 123, Jakarta',
          controller: controller.alamatPengirimanController,
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: Get.width,
          child: ElevatedButton(
            onPressed: () {
              pesanan != null
                  ? controller.updatePesanan(pesanan!.id)
                  : controller.addPesanan();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Themes.primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              pesanan != null ? 'Update' : 'Simpan',
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

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        backgroundColor: color.withAlpha(50),
        foregroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: onTap,
      icon: Icon(icon, size: 18),
      label: Text(label),
    );
  }
}
