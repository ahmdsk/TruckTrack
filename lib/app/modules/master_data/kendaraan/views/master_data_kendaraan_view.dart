import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'package:get/get.dart';
import 'package:truck_track/app/models/kendaraan.dart';
import 'package:truck_track/components/not_found_data.dart';
import 'package:truck_track/core/themes/themes.dart';

import '../controllers/master_data_kendaraan_controller.dart';

class MasterDataKendaraanView extends GetView<MasterDataKendaraanController> {
  const MasterDataKendaraanView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kelola Kendaraan',
          style: Themes.subTitleStyle.copyWith(
            color: Themes.darkColor,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              debugPrint('Add Kendaraan');
            },
            icon: Icon(FeatherIcons.plus, color: Themes.primaryColor),
          ),
        ],
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Obx(
          () =>
              controller.listKendaraan.isEmpty
                  ? const NotFoundData()
                  : ListView.builder(
                    itemCount: controller.listKendaraan.length,
                    itemBuilder: (context, index) {
                      return ItemListKendaraan(
                        kendaraan: controller.listKendaraan[index],
                      );
                    },
                  ),
        ),
      ),
    );
  }
}

class ItemListKendaraan extends StatelessWidget {
  const ItemListKendaraan({super.key, required this.kendaraan});

  final Kendaraan kendaraan;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Themes.whiteColor,
        boxShadow: [
          BoxShadow(
            color: Themes.darkColor.withAlpha(20), // Lebih transparan
            blurRadius: 6, // Lebih menyebar
            spreadRadius: 1, // Menyebar tipis
            offset: const Offset(0, 2), // Lebih pendek bayangannya
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage('assets/images/truck-list.jpg'),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    kendaraan.jenisKendaraan,
                    style: Themes.titleStyle.copyWith(
                      color: Themes.primaryColor,
                      fontSize: 18,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    kendaraan.noPolisi,
                    style: Themes.subTitleStyle.copyWith(
                      color: Themes.darkColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(FeatherIcons.edit, color: Themes.primaryColor),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(FeatherIcons.trash2, color: Themes.dangerColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
