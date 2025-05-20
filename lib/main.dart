import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:truck_track/app/controllers/auth_controller.dart';
import 'package:truck_track/app/data/api_client.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ApiClient.init();
  Get.put(AuthController());

  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}
