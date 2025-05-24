import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:truck_track/core/themes/themes.dart';

import '../controllers/setting_delivery_controller.dart';

class SettingDeliveryView extends GetView<SettingDeliveryController> {
  const SettingDeliveryView({super.key});
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
      ),
      body: Center(
        child: Text('Hello'),
      ),
    );
  }
}