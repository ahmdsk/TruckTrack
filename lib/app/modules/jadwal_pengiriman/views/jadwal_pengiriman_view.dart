import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:truck_track/app/models/jadwal_pengiriman.dart';
import 'package:truck_track/components/not_found_data.dart';
import 'package:truck_track/core/themes/themes.dart';

import '../controllers/jadwal_pengiriman_controller.dart';

class JadwalPengirimanView extends GetView<JadwalPengirimanController> {
  const JadwalPengirimanView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Jadwal Pengiriman',
          style: Themes.subTitleStyle.copyWith(
            color: Themes.darkColor,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () =>
            controller.listJadwalPengiriman.isEmpty
                ? NotFoundData()
                : ListView.builder(
                  itemCount: controller.listJadwalPengiriman.length,
                  itemBuilder: (context, index) {
                    final jadwal = controller.listJadwalPengiriman[index];
                    return CardJadwalPengiriman(jadwalPengiriman: jadwal);
                  },
                ),
      ),
    );
  }
}

class CardJadwalPengiriman extends StatelessWidget {
  const CardJadwalPengiriman({super.key, required this.jadwalPengiriman});

  final JadwalPengiriman jadwalPengiriman;

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
              fontSize: 16,
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'Tidak ada tujuan kirim',
                    style: Themes.bodyStyle.copyWith(
                      fontSize: 14,
                      color: Themes.darkColor.withAlpha(90),
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
                        'Tujuan #${tujuan.id}',
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
                    ],
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
