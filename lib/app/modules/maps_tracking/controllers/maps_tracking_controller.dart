import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:truck_track/app/models/tujuan_kirim.dart';

class MapsTrackingController extends GetxController {
  static const accessToken =
      'pk.eyJ1IjoiYWhtYWQyMjQyMTA0NCIsImEiOiJjbWFzanlpbHUwbTZ5Mmtvbjk0cnJkeWllIn0.kE8mdizng7w3Kiii-UOboA';
  late MapboxMap mapboxMap;
  late TujuanKirim tujuanKirim;

  Future<void> initTracking(TujuanKirim cekPesanan) async {
    tujuanKirim = cekPesanan;
  }

  void onMapReady(MapboxMap map) async {
    mapboxMap = map;

    final startLat = double.tryParse(tujuanKirim.latitudeAsal);
    final startLng = double.tryParse(tujuanKirim.longitudeAsal);
    final endLat = double.tryParse(tujuanKirim.latitudeTujuan);
    final endLng = double.tryParse(tujuanKirim.longitudeTujuan);

    if (startLat == null ||
        startLng == null ||
        endLat == null ||
        endLng == null) {
      return;
    }

    // Set camera ke titik awal
    await mapboxMap.setCamera(
      CameraOptions(
        center: Point(coordinates: Position(startLng, startLat)),
        zoom: 13.0,
      ),
    );

    // Tambahkan marker
    final annotationManager =
        await mapboxMap.annotations.createPointAnnotationManager();

    await annotationManager.create(
      PointAnnotationOptions(
        geometry: Point(coordinates: Position(startLng, startLat)),
        iconImage: "marker-15",
        iconSize: 1.5,
      ),
    );

    await annotationManager.create(
      PointAnnotationOptions(
        geometry: Point(coordinates: Position(endLng, endLat)),
        iconImage: "marker-15",
        iconSize: 1.5,
      ),
    );

    // Ambil direction route dari Mapbox Directions API
    final url =
        'https://api.mapbox.com/directions/v5/mapbox/driving/$startLng,$startLat;$endLng,$endLat?geometries=geojson&overview=full&access_token=$accessToken';

    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body);

    final coordinates = data['routes'][0]['geometry']['coordinates'] as List;

    final List<Position> polylinePoints =
        coordinates
            .map<Position>((coord) => Position(coord[0], coord[1]))
            .toList();

    // Gambar polyline
    final polylineManager =
        await mapboxMap.annotations.createPolylineAnnotationManager();

    await polylineManager.create(
      PolylineAnnotationOptions(
        geometry: LineString(coordinates: polylinePoints),
        lineColor: Colors.blue.toARGB32(),
        lineWidth: 9.0,
      ),
    );
  }
}
