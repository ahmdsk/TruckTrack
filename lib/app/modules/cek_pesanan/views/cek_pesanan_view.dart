import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:truck_track/app/models/cek_pesanan_costumer.dart';
import 'package:truck_track/app/modules/jadwal_driver/views/jadwal_driver_view.dart';
import 'package:truck_track/components/confirmation_dialog.dart';
import 'package:truck_track/components/not_found_data.dart';
import 'package:truck_track/core/themes/themes.dart';

import '../controllers/cek_pesanan_controller.dart';

class CekPesananView extends GetView<CekPesananController> {
  const CekPesananView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cek Pesanan',
          style: Themes.subTitleStyle.copyWith(
            color: Themes.darkColor,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () =>
            controller.listPesananCostumers.isEmpty
                ? NotFoundData()
                : ListView.builder(
                  itemCount: controller.listPesananCostumers.length,
                  itemBuilder: (context, index) {
                    final pesanan = controller.listPesananCostumers[index];
                    return CardPesananCostumer(pesananCostumer: pesanan);
                  },
                ),
      ),
    );
  }
}

class CardPesananCostumer extends StatelessWidget {
  const CardPesananCostumer({super.key, required this.pesananCostumer});

  final CekPesananCostumer pesananCostumer;

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
          // No Pesanan between dengan Tanggal Pesanan
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                pesananCostumer.noPesanan,
                style: Themes.titleStyle.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                formatter.format(
                  DateTime.parse(pesananCostumer.tanggalPesanan.toString()),
                ),
                style: Themes.bodyStyle.copyWith(fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Nama Driver
          Row(
            children: [
              Icon(Icons.person, size: 18, color: Themes.primaryColor),
              const SizedBox(width: 8),
              Text(
                pesananCostumer.driver?.name ?? '-',
                style: Themes.bodyStyle.copyWith(fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Nama Manajer
          Row(
            children: [
              Icon(
                Icons.supervisor_account,
                size: 18,
                color: Themes.primaryColor,
              ),
              const SizedBox(width: 8),
              Text(
                pesananCostumer.manager?.name ?? '-',
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
              Expanded(
                child: Text(
                  '${pesananCostumer.jenisBbm} - ${pesananCostumer.volumeBbm} liter',
                  style: Themes.bodyStyle.copyWith(
                    fontSize: 14,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Kendaraan
          Row(
            children: [
              Icon(Icons.directions_car, size: 18, color: Themes.primaryColor),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  pesananCostumer.kendaraan?.jenisKendaraan ?? '-',
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
                  '${pesananCostumer.kendaraan?.noSegelAtas ?? '-'} / ${pesananCostumer.kendaraan?.noSegelBawah ?? '-'}',
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
                  pesananCostumer.kendaraan?.noSuratJalan ?? '-',
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
                    (pesananCostumer.statusPesanan == 'selesai')
                        ? Themes.successColor
                        : Themes.primaryColor,
              ),
              const SizedBox(width: 8),
              Text(
                formatMessageStatusPesanan(pesananCostumer.statusPesanan),
                style: Themes.bodyStyle.copyWith(
                  fontSize: 14,
                  color:
                      (pesananCostumer.statusPesanan == 'selesai')
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
                    (pesananCostumer.telahDiterima == 1)
                        ? Themes.successColor
                        : Themes.darkColor,
              ),
              const SizedBox(width: 8),
              Text(
                pesananCostumer.telahDiterima == 1
                    ? "Pesanan Sudah Diterima"
                    : "Pesanan Belum Diterima",
                style: Themes.bodyStyle.copyWith(
                  fontSize: 14,
                  color:
                      (pesananCostumer.telahDiterima == 1)
                          ? Themes.successColor
                          : Themes.darkColor,
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
                  pesananCostumer.alamatPengiriman,
                  style: Themes.bodyStyle.copyWith(fontSize: 14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          const Divider(),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                Get.bottomSheet(
                  isScrollControlled: true,
                  Container(
                    height: Get.height * 0.6,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Themes.whiteColor,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Tujuan Kirim (simple list)
                          if (pesananCostumer.tujuanKirim.isEmpty)
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12.0,
                                ),
                                child: Text(
                                  pesananCostumer.statusPesanan == 'selesai'
                                      ? 'Pengiriman selesai, tidak ada rute.'
                                      : 'Belum ada rute untuk pengiriman ini.',
                                  style: Themes.bodyStyle.copyWith(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            )
                          else
                            ...pesananCostumer.tujuanKirim.map(
                              (tujuan) => Container(
                                margin: const EdgeInsets.only(top: 8),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Themes.whiteColor,
                                  border: Border.all(
                                    color: Colors.grey.shade200,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${tujuan.alamatAsal} ➔ ${tujuan.alamatTujuan}',
                                      style: Themes.bodyStyle.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        overflow: TextOverflow.fade,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${tujuan.jarak} km • ${tujuan.waktuTempuh} menit',
                                      style: Themes.bodyStyle.copyWith(
                                        fontSize: 13,
                                      ),
                                    ),
                                    if ((tujuan.catatan ?? '').isNotEmpty)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 4),
                                        child: Text(
                                          'Catatan: ${tujuan.catatan}',
                                          style: Themes.bodyStyle.copyWith(
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.check_circle,
                                          size: 16,
                                          color:
                                              tujuan.sudahDilewati == 1
                                                  ? Themes.successColor
                                                  : Colors.grey,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          tujuan.sudahDilewati == 1
                                              ? 'Sudah dilewati'
                                              : 'Belum dilewati',
                                          style: Themes.bodyStyle.copyWith(
                                            color:
                                                tujuan.sudahDilewati == 1
                                                    ? Themes.successColor
                                                    : Colors.grey,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    // Button untuk melihat maps
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton.icon(
                                        onPressed: () {
                                          Get.toNamed(
                                            '/maps-tracking',
                                            arguments: tujuan,
                                          );
                                        },
                                        icon: Icon(
                                          Icons.map,
                                          size: 18,
                                          color: Themes.whiteColor,
                                        ),
                                        label: Text(
                                          "Lihat di Maps",
                                          style: Themes.bodyStyle.copyWith(
                                            fontSize: 14,
                                            color: Themes.whiteColor,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          backgroundColor: Themes.primaryColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              icon: Icon(Icons.location_on, size: 18, color: Themes.whiteColor),
              label: Text(
                "Detail Tujuan Kirim",
                style: Themes.bodyStyle.copyWith(
                  fontSize: 14,
                  color: Themes.whiteColor,
                ),
              ),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Themes.primaryColor,
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                if (pesananCostumer.telahDiterima == 0) {
                  ConfirmationDialog.show(
                    title: 'Konfirmasi Pesanan Diterima',
                    description:
                        'Apakah anda yakin pesanan ini sudah diterima?',
                    onConfirm: () {
                      final controller = Get.find<CekPesananController>();
                      controller.konfirmasiPesanan(
                        pesananCostumer.id.toString(),
                      );
                    },
                  );
                }
              },
              icon: Icon(
                Icons.check_circle,
                size: 18,
                color: Themes.whiteColor,
              ),
              label: Text(
                // "Pesanan Diterima",
                pesananCostumer.telahDiterima == 1
                    ? "Pesanan Sudah Diterima"
                    : "Konfirmasi Pesanan Diterima",
                style: Themes.bodyStyle.copyWith(
                  fontSize: 14,
                  color: Themes.whiteColor,
                ),
              ),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: pesananCostumer.telahDiterima == 1
                    ? Themes.successColor
                    : Themes.darkColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
