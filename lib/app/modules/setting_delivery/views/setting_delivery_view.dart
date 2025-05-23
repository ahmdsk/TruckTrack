import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:truck_track/core/themes/themes.dart';

import '../controllers/setting_delivery_controller.dart';

class SettingDeliveryView extends GetView<SettingDeliveryController> {
  const SettingDeliveryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Atur Pengiriman',
          style: Themes.subTitleStyle.copyWith(
            color: Themes.darkColor,
            fontSize: 18,
          ),
        ),
      ),
      body: ListView.builder(
        itemBuilder: (_, index) {
          return const PengirimanCard();
        },
        itemCount: 10,
      ),
    );
  }
}

class PengirimanCard extends StatelessWidget {
  const PengirimanCard({super.key});

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
                  'PESANAN-001',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Themes.darkColor,
                  ),
                ),
                Text(
                  formatter.format(DateTime.parse('2025-05-19 17:01:14')),
                  style: TextStyle(fontSize: 13, color: Themes.darkColor.withAlpha(150)),
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
              child: const Text(
                'MENUNGGU',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Jenis dan Volume BBM
            Row(
              children: [
                Icon(Icons.local_gas_station, size: 18, color: Themes.darkColor.withAlpha(120)),
                SizedBox(width: 8),
                Text('Pertalite • 100 Liter'),
              ],
            ),
            const SizedBox(height: 10),

            // Alamat
            Row(
              children: [
                Icon(Icons.location_on, size: 18, color: Themes.darkColor.withAlpha(120)),
                SizedBox(width: 8),
                Expanded(child: Text('Jl. Raya No. 1, Jakarta')),
              ],
            ),
            const SizedBox(height: 10),

            // Driver dan Customer
            Row(
              children: [
                Icon(Icons.person_outline, size: 18, color: Themes.darkColor.withAlpha(120)),
                SizedBox(width: 8),
                Expanded(
                  child: Text('Driver: Driver 1 | Customer: Costumer 1'),
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
                      // TODO: Aksi edit
                    },
                  ),
                ),
                Expanded(
                  child: _ActionButton(
                    label: 'Hapus',
                    icon: Icons.delete,
                    color: Colors.redAccent,
                    onTap: () {
                      // TODO: Aksi hapus
                    },
                  ),
                ),
                Expanded(
                  child: _ActionButton(
                    label: 'Atur',
                    icon: Icons.settings,
                    color: Colors.deepOrange,
                    onTap: () {
                      // TODO: Aksi atur
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
        backgroundColor: color.withOpacity(0.1),
        foregroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: onTap,
      icon: Icon(icon, size: 18),
      label: Text(label),
    );
  }
}