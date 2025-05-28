import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:truck_track/app/models/jenis_bbm.dart';
import 'package:truck_track/app/models/kendaraan.dart';
import 'package:truck_track/app/models/pesanan.dart';
import 'package:truck_track/app/models/user.dart';
import 'package:truck_track/app/modules/jadwal_driver/views/jadwal_driver_view.dart';
import 'package:truck_track/components/action_button_card.dart';
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
            controller.listOrders.isEmpty
                ? const NotFoundData()
                : ListView.builder(
                  itemCount: controller.listOrders.length,
                  itemBuilder: (context, index) {
                    return PengirimanCard(
                      pesanan: controller.listOrders[index],
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
                Expanded(
                  child: Text(
                    '${pesanan.jenisBbm} • ${pesanan.volumeBbm} Liter',
                    style: Themes.bodyStyle.copyWith(
                      color: Themes.darkColor.withAlpha(150),
                      fontSize: 14,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
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

            // Kendaraan
            Row(
              children: [
                Icon(
                  Icons.directions_car,
                  size: 18,
                  color: Themes.darkColor.withAlpha(120),
                ),
                SizedBox(width: 8),
                Expanded(child: Text(pesanan.kendaraan?.jenisKendaraan ?? '-')),
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

            // Kendaraan
          Row(
            children: [
              Icon(Icons.directions_car, size: 18, color: Themes.primaryColor),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  pesanan.kendaraan?.jenisKendaraan ?? '-',
                  style: Themes.bodyStyle.copyWith(
                    fontSize: 14,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // No Atas & No Bawah Segel
          Row(
            children: [
              Icon(
                Icons.confirmation_number,
                size: 18,
                color: Themes.primaryColor,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '${pesanan.kendaraan?.noSegelAtas ?? '-'} / ${pesanan.kendaraan?.noSegelBawah ?? '-'}',
                  style: Themes.bodyStyle.copyWith(fontSize: 14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // No Surat Jalan
          Row(
            children: [
              Icon(
                Icons.document_scanner,
                size: 18,
                color: Themes.primaryColor,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  pesanan.kendaraan?.noSuratJalan ?? '-',
                  style: Themes.bodyStyle.copyWith(fontSize: 14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Status Pengiriman
          Row(
            children: [
              Icon(
                Icons.delivery_dining,
                size: 18,
                color:
                    (pesanan.statusPesanan == 'selesai')
                        ? Themes.successColor
                        : Themes.primaryColor,
              ),
              const SizedBox(width: 8),
              Text(
                formatMessageStatusPesanan(pesanan.statusPesanan),
                style: Themes.bodyStyle.copyWith(
                  fontSize: 14,
                  color:
                      (pesanan.statusPesanan == 'selesai')
                          ? Themes.successColor
                          : Themes.primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Status Diterima
          Row(
            children: [
              Icon(
                Icons.check_circle,
                size: 18,
                color:
                    (pesanan.telahDiterima == 1)
                        ? Themes.successColor
                        : Themes.darkColor,
              ),
              const SizedBox(width: 8),
              Text(
                pesanan.telahDiterima == 1
                    ? "Pesanan Sudah Diterima"
                    : "Pesanan Belum Diterima",
                style: Themes.bodyStyle.copyWith(
                  fontSize: 14,
                  color:
                      (pesanan.telahDiterima == 1)
                          ? Themes.successColor
                          : Themes.darkColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

            const SizedBox(height: 20),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 8,
              children: [
                Expanded(
                  child: ActionButtonCard(
                    label: 'Edit',
                    icon: Icons.edit,
                    color: Colors.blueAccent,
                    onTap: () async {
                      debugPrint('Edit ${pesanan.noPesanan}');
                      final editPesanan = await Get.bottomSheet(
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

                      if (editPesanan == null) {
                        final controller = Get.find<SettingOrderController>();
                        controller.clearForm();
                      }
                    },
                  ),
                ),
                Expanded(
                  child: ActionButtonCard(
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
                          final controller = Get.find<SettingOrderController>();
                          controller.deletePesanan(pesanan.id);
                        },
                      );
                    },
                  ),
                ),
                Expanded(
                  child: ActionButtonCard(
                    label: 'Atur',
                    icon: Icons.settings,
                    color: Themes.successColor,
                    onTap: () {
                      Get.toNamed('/setting-delivery?orderId=${pesanan.id}');
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
      controller.selectedBBM.value = controller.listBBM.firstWhereOrNull(
        (e) => e.nama == pesanan!.jenisBbm,
      );
      controller.selectedKendaraan.value = controller.listKendaraan
          .firstWhereOrNull((e) => e.id == pesanan!.kendaraanId);
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
          title: 'Purchase Order',
          hintText: 'Contoh: P1234567890',
          controller: controller.noPesananController,
        ),
        const SizedBox(height: 20),
        Obx(() {
          final jenisBbm = controller.listBBM;
          return Dropdown<JenisBbm>(
            title: "Pilih Jenis BBM",
            hintText: "Pilih salah satu jenis bbm",
            value: controller.selectedBBM.value,
            onChanged: (val) => controller.selectedBBM.value = val,
            items:
                jenisBbm
                    .map(
                      (driver) => DropdownMenuItem(
                        value: driver,
                        child: Text(driver.nama),
                      ),
                    )
                    .toList(),
          );
        }),
        const SizedBox(height: 20),
        Obx(() {
          final jenisKendaraan = controller.listKendaraan;
          return Dropdown<Kendaraan>(
            title: "Pilih Kendaraan",
            hintText: "Pilih salah satu kendaraan",
            value: controller.selectedKendaraan.value,
            onChanged: (val) => controller.selectedKendaraan.value = val,
            items:
                jenisKendaraan
                    .map(
                      (driver) => DropdownMenuItem(
                        value: driver,
                        child: Text(driver.jenisKendaraan),
                      ),
                    )
                    .toList(),
          );
        }),
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
