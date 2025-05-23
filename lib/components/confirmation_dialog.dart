import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:truck_track/core/themes/themes.dart';

class ConfirmationDialog {
  static void show({
    required String title,
    required String description,
    required VoidCallback onConfirm,
    String confirmText = 'Ya',
    String cancelText = 'Tidak',
  }) {
    Get.defaultDialog(
      titlePadding: const EdgeInsets.only(top: 20),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      backgroundColor: Themes.whiteColor,
      titleStyle: TextStyle(
        color: Themes.darkColor,
        fontWeight: FontWeight.bold,
      ),
      middleTextStyle: TextStyle(
        color: Themes.darkColor,
        fontSize: 16,
      ),
      radius: 10,
      title: title,
      middleText: description,
      confirm: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Themes.dangerColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {
          onConfirm();
          Get.back(closeOverlays: true);
        },
        child: Text(
          confirmText,
          style: TextStyle(color: Themes.whiteColor),
        ),
      ),
      cancel: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Themes.secondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () => Get.back(),
        child: Text(
          cancelText,
          style: TextStyle(color: Themes.darkColor),
        ),
      ),
    );
  }
}