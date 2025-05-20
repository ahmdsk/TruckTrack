import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

// pk.eyJ1IjoiYWhtYWQyMjQyMTA0NCIsImEiOiJjbWFzanlpbHUwbTZ5Mmtvbjk0cnJkeWllIn0.kE8mdizng7w3Kiii-UOboA

class MapsController extends GetxController {
  late MapboxMap mapboxMap;
  final String accessToken =
      'pk.eyJ1IjoiYWhtYWQyMjQyMTA0NCIsImEiOiJjbWFzanlpbHUwbTZ5Mmtvbjk0cnJkeWllIn0.kE8mdizng7w3Kiii-UOboA';

  var totalDistanceKm = "0".obs;
  var totalDuration = "0m".obs;

  // Jakarta
  final startPoint = Point(coordinates: Position(106.794831, -6.196804));
  final endPoint = Point(coordinates: Position(106.781641, -6.248064));

  void onMapCreated(MapboxMap map) async {
    mapboxMap = map;

    // Arahkan kamera ke startPoint
    mapboxMap.setCamera(CameraOptions(center: startPoint, zoom: 14.0));

    // Gambar rute
    await drawRoute();
  }

  Future<void> drawRoute() async {
    final geometry = await fetchRoute();
    if (geometry != null) {
      final style = mapboxMap.style;

      await style.addSource(
        GeoJsonSource(
          id: "route_source",
          data: jsonEncode({"type": "Feature", "geometry": geometry}),
        ),
      );

      await style.addLayer(
        LineLayer(
          id: "route_layer",
          sourceId: "route_source",
          lineColor: Colors.blue.toARGB32(),
          lineWidth: 8.0,
        ),
      );
    }
  }

  Future<Map<String, dynamic>?> fetchRoute() async {
    final url =
        "https://api.mapbox.com/directions/v5/mapbox/driving/${startPoint.coordinates.lng},${startPoint.coordinates.lat};${endPoint.coordinates.lng},${endPoint.coordinates.lat}?alternatives=true&geometries=geojson&language=en&overview=full&steps=true&access_token=$accessToken";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // convert response.body to DirectionMaps
      final data = jsonDecode(response.body);
      debugPrint('Response Data Maps nya: $data');

      final route = data['routes'][0];

      // Ambil geometry, distance (meter), dan duration (detik)
      final geometry = route['geometry'];
      final distance = route['distance'];
      final duration = route['duration'];

      // Simpan data ke controller (bisa pakai Rx untuk reactive)
      totalDistanceKm.value = (distance! / 1000).toStringAsFixed(2);
      totalDuration.value = formatDuration(Duration(seconds: duration!.round()));

      return geometry;
    } else {
      debugPrint("Failed to fetch directions: ${response.body}");
      return null;
    }
  }

  String formatDuration(Duration d) {
    final hours = d.inHours;
    final minutes = d.inMinutes.remainder(60);
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
