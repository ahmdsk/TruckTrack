import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:truck_track/app/models/tujuan_kirim.dart';
import 'package:truck_track/core/themes/themes.dart';

import '../controllers/maps_tracking_controller.dart';

class MapsTrackingView extends GetView<MapsTrackingController> {
  const MapsTrackingView({super.key});

  @override
  Widget build(BuildContext context) {
    final TujuanKirim tujuanKirim = Get.arguments;
    controller.initTracking(tujuanKirim);

    MapboxOptions.setAccessToken(MapsTrackingController.accessToken);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tracking Pesanan',
          style: Themes.subTitleStyle.copyWith(
            color: Themes.darkColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // MAP VIEW
          Expanded(
            flex: 1,
            child: MapWidget(
              key: const ValueKey("mapWidget"),
              onMapCreated: controller.onMapReady,
            ),
          ),

          // INFORMATION CARD
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Detail Rute',
                            style: Themes.subTitleStyle.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Themes.primaryColor,
                            ),
                          ),

                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 10,
                            ),
                            decoration: BoxDecoration(
                              color: tujuanKirim.sudahDilewati == 1
                                  ? Themes.successColor
                                  : Themes.dangerColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              tujuanKirim.sudahDilewati == 1
                                  ? 'Sudah dilewati'
                                  : 'Belum dilewati',
                              style: Themes.subTitleStyle.copyWith(
                                color: Themes.whiteColor,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Divider(),

                      // Info Items
                      _buildInfoRow(
                        icon: Icons.location_on,
                        label: 'Alamat Asal',
                        value: tujuanKirim.alamatAsal,
                        multiline: true,
                      ),
                      _buildInfoRow(
                        icon: Icons.location_on,
                        label: 'Alamat Tujuan',
                        value: tujuanKirim.alamatTujuan,
                        multiline: true,
                      ),
                      _buildInfoRow(
                        icon: Icons.time_to_leave,
                        label: 'Perkiraan Waktu Pengiriman',
                        value: '${tujuanKirim.waktuTempuh.toString()} menit',
                      ),
                      _buildInfoRow(
                        icon: Icons.calendar_today,
                        label: 'Jarak Tempuh',
                        value: '${tujuanKirim.jarak.toString()} km',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper Widget
  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    bool multiline = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment:
            multiline ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 20, color: Themes.primaryColor),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Themes.bodyStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: Themes.bodyStyle.copyWith(
                    fontSize: 14,
                    color: Themes.darkColor,
                    overflow:
                        multiline
                            ? TextOverflow.visible
                            : TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
