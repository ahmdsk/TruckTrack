import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomSnackbar({
  required String title,
  required String message,
  Color backgroundColor = Colors.white,
  Color textColor = Colors.black87,
  IconData icon = Icons.info_outline,
  Color iconColor = Colors.blue,
  SnackPosition position = SnackPosition.TOP,
}) {
  Get.snackbar(
    title,
    message,
    snackPosition: position,
    backgroundColor: backgroundColor,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    padding: const EdgeInsets.all(16),
    borderRadius: 12,
    icon: Icon(icon, color: iconColor, size: 24),
    shouldIconPulse: false,
    duration: const Duration(seconds: 3),
    isDismissible: true,
    forwardAnimationCurve: Curves.easeOutBack,
    titleText: Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: textColor,
      ),
    ),
    messageText: Text(
      message,
      style: TextStyle(fontSize: 14, color: textColor.withAlpha(100)),
    ),
  );
}
