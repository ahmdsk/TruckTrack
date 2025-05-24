import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:truck_track/app/models/jadwal_pengiriman_driver.dart';
import 'package:truck_track/app/models/tujuan_kirim.dart';
import 'package:truck_track/components/confirmation_dialog.dart';
import 'package:truck_track/components/input.dart';
import 'package:truck_track/components/not_found_data.dart';
import 'package:truck_track/components/snackbar.dart';
import 'package:truck_track/core/themes/themes.dart';

import '../controllers/jadwal_driver_controller.dart';

class JadwalDriverView extends GetView<JadwalDriverController> {
  const JadwalDriverView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Jadwal Saya',
          style: Themes.subTitleStyle.copyWith(
            color: Themes.darkColor,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () =>
            controller.listJadwalPengirimanDrivers.isEmpty
                ? NotFoundData()
                : ListView.builder(
                  itemCount: controller.listJadwalPengirimanDrivers.length,
                  itemBuilder: (context, index) {
                    final jadwal =
                        controller.listJadwalPengirimanDrivers[index];
                    return CardJadwalPengirimanDriver(jadwalPengiriman: jadwal);
                  },
                ),
      ),
    );
  }
}

class CardJadwalPengirimanDriver extends StatelessWidget {
  const CardJadwalPengirimanDriver({super.key, required this.jadwalPengiriman});

  final JadwalPengirimanDriver jadwalPengiriman;

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd MMM yyyy, HH:mm');

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Themes.whiteColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Themes.darkColor.withAlpha(20),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header - No Pesanan
          Text(
            jadwalPengiriman.noPesanan,
            style: Themes.titleStyle.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),

          // Tanggal Pesanan
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                size: 18,
                color: Themes.darkColor.withAlpha(90),
              ),
              const SizedBox(width: 8),
              Text(
                formatter.format(
                  DateTime.parse(jadwalPengiriman.tanggalPesanan.toString()),
                ),
                style: Themes.bodyStyle.copyWith(fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Nama Costumer
          Row(
            children: [
              Icon(Icons.person, size: 18, color: Themes.primaryColor),
              const SizedBox(width: 8),
              Text(
                jadwalPengiriman.costumer?.name ?? '-',
                style: Themes.bodyStyle.copyWith(fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Jenis & Volume BBM
          Row(
            children: [
              Icon(
                Icons.local_gas_station,
                size: 18,
                color: Themes.primaryColor,
              ),
              const SizedBox(width: 8),
              Text(
                '${jadwalPengiriman.jenisBbm} - ${jadwalPengiriman.volumeBbm} liter',
                style: Themes.bodyStyle.copyWith(fontSize: 14),
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
                    (jadwalPengiriman.statusPesanan == 'selesai')
                        ? Themes.successColor
                        : Themes.primaryColor,
              ),
              const SizedBox(width: 8),
              Text(
                formatMessageStatusPesanan(jadwalPengiriman.statusPesanan),
                style: Themes.bodyStyle.copyWith(
                  fontSize: 14,
                  color:
                      (jadwalPengiriman.statusPesanan == 'selesai')
                          ? Themes.successColor
                          : Themes.primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Alamat Pengiriman
          Row(
            children: [
              Icon(Icons.location_on, size: 18, color: Themes.successColor),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  jadwalPengiriman.alamatPengiriman,
                  style: Themes.bodyStyle.copyWith(fontSize: 14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          const Divider(),

          // Tujuan Kirim (loop)
          ...jadwalPengiriman.tujuanKirim.isEmpty
              ? [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      jadwalPengiriman.statusPesanan == 'selesai'
                          ? 'Pengiriman sudah selesai, tidak ada rute yang perlu dilewati.'
                          : 'Tidak ada rute yang ditentukan untuk pengiriman ini.',
                      style: Themes.bodyStyle.copyWith(
                        fontSize: 14,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                ),
              ]
              : jadwalPengiriman.tujuanKirim.map(
                (tujuan) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Rute',
                        style: Themes.subTitleStyle.copyWith(fontSize: 16),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(
                            Icons.my_location,
                            size: 16,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              'Asal: ${tujuan.alamatAsal}',
                              style: Themes.bodyStyle.copyWith(
                                fontSize: 14,
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.flag, size: 16, color: Colors.red),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              'Tujuan: ${tujuan.alamatTujuan}',
                              style: Themes.bodyStyle.copyWith(fontSize: 14),
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.directions,
                            size: 16,
                            color: Colors.blue,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '${tujuan.jarak} km • ${tujuan.waktuTempuh} menit',
                            style: Themes.bodyStyle.copyWith(fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      // Catatan Rute
                      Row(
                        children: [
                          const Icon(Icons.note, size: 16, color: Colors.grey),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              tujuan.catatan ?? 'Tidak ada catatan',
                              style: Themes.bodyStyle.copyWith(fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 16,
                            color:
                                (tujuan.sudahDilewati == 1)
                                    ? Themes.successColor
                                    : Themes.darkColor.withAlpha(90),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            (tujuan.sudahDilewati == 1)
                                ? 'Sudah dilewati'
                                : 'Belum dilewati',
                            style: Themes.bodyStyle.copyWith(
                              color:
                                  (tujuan.sudahDilewati == 1)
                                      ? Themes.successColor
                                      : Themes.darkColor.withAlpha(90),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              onPressed: () {
                                Get.bottomSheet(
                                  isScrollControlled: true,
                                  Container(
                                    height: Get.height * 0.4,
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: Themes.whiteColor,
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20),
                                      ),
                                    ),
                                    child: SingleChildScrollView(
                                      child: FormCatatanRute(
                                        tujuanKirim: tujuan,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.note_add_outlined,
                                size: 16,
                              ),
                              label: Text(
                                "Berikan Catatan",
                                style: Themes.bodyStyle.copyWith(fontSize: 14),
                              ),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Themes.primaryColor,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              onPressed: () {
                                if (jadwalPengiriman.statusPesanan ==
                                    'menunggu') {
                                  ConfirmationDialog.show(
                                    title: 'Mulai Pengiriman',
                                    description:
                                        'Apakah Anda yakin ingin memulai pengiriman untuk tujuan ini?',
                                    onConfirm: () {
                                      final controller =
                                          Get.find<JadwalDriverController>();
                                      controller.startDelivery(
                                        jadwalPengiriman.id.toString(),
                                      );
                                    },
                                  );
                                } else {
                                  showCustomSnackbar(
                                    title: 'Informasi',
                                    message:
                                        'Pengiriman sudah dimulai untuk tujuan ini.',
                                  );
                                }
                              },
                              icon: const Icon(Icons.delivery_dining, size: 16),
                              label: Text(
                                jadwalPengiriman.statusPesanan == 'menunggu'
                                    ? 'Mulai Pengiriman'
                                    : 'Dalam Proses',
                                style: Themes.bodyStyle.copyWith(fontSize: 14),
                              ),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Themes.primaryColor,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                debugPrint(
                                  "Tandai Sudah Dilewati: ${tujuan.id}",
                                );

                                ConfirmationDialog.show(
                                  title: 'Tandai Sudah Dilewati',
                                  description:
                                      'Apakah Anda yakin sudah melewati rute ini?',
                                  onConfirm: () {
                                    final controller =
                                        Get.find<JadwalDriverController>();
                                    controller.completeDelivery(
                                      tujuan.id.toString(),
                                    );
                                  },
                                );
                              },
                              icon: const Icon(
                                Icons.check,
                                size: 16,
                                color: Colors.white,
                              ),
                              label: Text(
                                "Tandai Sudah Dilewati",
                                style: Themes.bodyStyle.copyWith(
                                  fontSize: 14,
                                  color: Themes.whiteColor,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: Themes.successColor,
                                disabledBackgroundColor: Colors.grey[300],
                                disabledForegroundColor: Colors.grey[600],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
        ],
      ),
    );
  }
}

String formatMessageStatusPesanan(String status) {
  switch (status) {
    case 'menunggu':
      return 'Menunggu';
    case 'dalam_proses':
      return 'Dalam Proses';
    case 'selesai':
      return 'Selesai';
    default:
      return 'Tidak Diketahui';
  }
}

class FormCatatanRute extends StatelessWidget {
  const FormCatatanRute({super.key, this.tujuanKirim});

  final TujuanKirim? tujuanKirim;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<JadwalDriverController>();

    // jika dalam mode edit, isi form dengan catatan yang sudah ada
    if (tujuanKirim != null) {
      controller.catatanController.text = tujuanKirim!.catatan ?? '';
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          tujuanKirim != null ? 'Edit Catatan' : 'Tambah Catatan',
          style: Themes.titleStyle.copyWith(
            color: Themes.primaryColor,
            fontSize: 18,
          ),
        ),

        const SizedBox(height: 20),
        InputField(
          title: 'Catatan',
          hintText: 'Contoh: ada kendala di rute ini',
          controller: controller.catatanController,
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: Get.width,
          child: ElevatedButton(
            onPressed: () async {
              await controller.addDeliveryNote(
                tujuanKirim?.id.toString() ?? '',
                controller.catatanController.text,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Themes.primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              tujuanKirim != null ? 'Simpan Catatan' : 'Tambah Catatan',
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
