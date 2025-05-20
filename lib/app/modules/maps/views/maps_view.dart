import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

import '../controllers/maps_controller.dart';

class MapsView extends GetView<MapsController> {
  const MapsView({super.key});

  @override
  Widget build(BuildContext context) {
    MapboxOptions.setAccessToken(controller.accessToken);

    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Column(
            children: [
              Text("Jarak: ${controller.totalDistanceKm.value} km"),
              Text("Waktu tempuh: ${controller.totalDuration.value}"),
            ],
          ),
        ),
      ),
      body: MapWidget(
        key: const ValueKey("mapWidget"),
        onMapCreated: controller.onMapCreated,
      ),
    );
  }
}
