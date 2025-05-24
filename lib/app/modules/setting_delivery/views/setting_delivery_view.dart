import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:truck_track/app/models/tujuan_kirim.dart';
import 'package:truck_track/components/action_button_card.dart';
import 'package:truck_track/components/not_found_data.dart';
import 'package:truck_track/core/themes/themes.dart';

import '../controllers/setting_delivery_controller.dart';

class SettingDeliveryView extends GetView<SettingDeliveryController> {
  const SettingDeliveryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Atur Tujuan Pengiriman',
          style: Themes.subTitleStyle.copyWith(
            color: Themes.darkColor,
            fontSize: 18,
          ),
        ),
      ),
      body: Obx(
        () =>
            controller.listDelivery.isEmpty
                ? NotFoundData()
                : ListView.builder(
                  itemCount: controller.listDelivery.length,
                  itemBuilder: (context, index) {
                    final delivery = controller.listDelivery[index];
                    return CardTujuanPengiriman(tujuanKirim: delivery);
                  },
                ),
      ),
    );
  }
}

class CardTujuanPengiriman extends StatelessWidget {
  const CardTujuanPengiriman({super.key, required this.tujuanKirim});

  final TujuanKirim tujuanKirim;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Themes.whiteColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Themes.darkColor.withAlpha(18),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: No Pesanan
          Text(
            tujuanKirim.pesanan?.noPesanan ?? '-',
            style: Themes.titleStyle.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Themes.darkColor,
            ),
          ),
          const SizedBox(height: 12),

          // Alamat Asal
          Row(
            children: [
              Icon(Icons.location_on_outlined, size: 18, color: Colors.green),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Asal: ${tujuanKirim.alamatAsal}',
                  style: Themes.bodyStyle.copyWith(fontSize: 14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Alamat Tujuan
          Row(
            children: [
              Icon(Icons.flag_outlined, size: 18, color: Colors.redAccent),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Tujuan: ${tujuanKirim.alamatTujuan}',
                  style: Themes.bodyStyle.copyWith(fontSize: 14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Jarak dan Waktu Tempuh
          Row(
            children: [
              Icon(Icons.directions, size: 18, color: Colors.blue),
              SizedBox(width: 8),
              Text(
                '${tujuanKirim.jarak} • ${tujuanKirim.waktuTempuh}',
                style: Themes.bodyStyle.copyWith(fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Catatan
          Row(
            children: [
              Icon(Icons.notes, size: 18, color: Colors.orange),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Catatan: ${tujuanKirim.catatan}',
                  style: Themes.bodyStyle.copyWith(fontSize: 14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Status dilewati
          Row(
            children: [
              Icon(
                Icons.check_circle,
                size: 18,
                color:
                    tujuanKirim.sudahDilewati == 1
                        ? Themes.successColor
                        : Themes.darkColor.withAlpha(100),
              ),
              const SizedBox(width: 8),
              Text(
                tujuanKirim.sudahDilewati == 1
                    ? 'Sudah dilewati'
                    : 'Belum dilewati',
                style: Themes.bodyStyle.copyWith(
                  fontWeight: FontWeight.w500,
                  color:
                      tujuanKirim.sudahDilewati == 1
                          ? Themes.successColor
                          : Themes.darkColor.withAlpha(140),
                  fontSize: 14,
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
                child: ActionButtonCard(
                  label: 'Edit',
                  icon: Icons.edit,
                  color: Colors.blueAccent,
                  onTap: () {
                    debugPrint('Edit ${tujuanKirim.pesanan?.noPesanan}');
                  },
                ),
              ),
              Expanded(
                child: ActionButtonCard(
                  label: 'Hapus',
                  icon: Icons.delete,
                  color: Themes.dangerColor,
                  onTap: () {
                    debugPrint('Hapus ${tujuanKirim.pesanan?.noPesanan}');
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
