import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:truck_track/app/models/tujuan_kirim.dart';
import 'package:truck_track/service_locator.dart';
import 'package:truck_track/services/delivery_service.dart';

class SettingDeliveryController extends GetxController {
  // List tujuan kirim
  final listDelivery = <TujuanKirim>[].obs;

  // Service
  final deliveryService = sl<DeliveryService>();

  // Text field controllers
  final asalController = TextEditingController();
  final tujuanController = TextEditingController();
  final catatan = TextEditingController();

  // Mapbox Token
  final mapboxToken = 'pk.eyJ1IjoiYWhtYWQyMjQyMTA0NCIsImEiOiJjbWFzanlpbHUwbTZ5Mmtvbjk0cnJkeWllIn0.kE8mdizng7w3Kiii-UOboA'; // TODO: Ganti token kamu

  // Alamat dan koordinat
  final alamatAsal = ''.obs;
  final alamatTujuan = ''.obs;
  final latAsal = ''.obs;
  final longAsal = ''.obs;
  final latTujuan = ''.obs;
  final longTujuan = ''.obs;

  // Jarak dan waktu tempuh
  final jarak = ''.obs;
  final waktu = ''.obs;

  // Hasil autocomplete dari Mapbox
  final hasilAsal = [].obs;
  final hasilTujuan = [].obs;

  // Timer debounce
  Timer? _debounceAsal;
  Timer? _debounceTujuan;

  // 🔍 Autocomplete debounce search
  void handleDebouncedSearch({required String value, required bool isAsal}) {
    final debounce = isAsal ? _debounceAsal : _debounceTujuan;

    if (debounce?.isActive ?? false) debounce!.cancel();

    final timer = Timer(const Duration(milliseconds: 500), () {
      if (value.isNotEmpty) cariTempat(value, isAsal);
    });

    if (isAsal) {
      _debounceAsal = timer;
    } else {
      _debounceTujuan = timer;
    }
  }

  // 📍 Memanggil Mapbox Geocoding API
  Future<void> cariTempat(String keyword, bool isAsal) async {
    final url = Uri.parse(
      'https://api.mapbox.com/geocoding/v5/mapbox.places/${Uri.encodeComponent(keyword)}.json?access_token=$mapboxToken&country=id',
    );

    final response = await http.get(url);
    debugPrint('HASIL CARI TEMPAT: ${response.body}');
    
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final fitur = data['features'] as List;
      if (isAsal) {
        hasilAsal.assignAll(fitur);
      } else {
        hasilTujuan.assignAll(fitur);
      }
    }
  }

  // ✅ Ketika user memilih tempat dari hasil autocomplete
  void pilihTempat(Map<String, dynamic> place, bool isAsal) {
    final name = place['place_name'];
    final coords = place['geometry']['coordinates'];

    if (isAsal) {
      asalController.text = name;
      alamatAsal.value = name;
      latAsal.value = coords[1].toString();
      longAsal.value = coords[0].toString();
      hasilAsal.clear();
    } else {
      tujuanController.text = name;
      alamatTujuan.value = name;
      latTujuan.value = coords[1].toString();
      longTujuan.value = coords[0].toString();
      hasilTujuan.clear();
    }
  }

  // 📏 Hitung jarak & waktu tempuh via Mapbox Directions API
  Future<void> hitungJarak() async {
    if (latAsal.isEmpty || latTujuan.isEmpty) return;

    final url = Uri.parse(
      'https://api.mapbox.com/directions/v5/mapbox/driving/${longAsal.value},${latAsal.value};${longTujuan.value},${latTujuan.value}?access_token=$mapboxToken',
    );
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    final route = data['routes'][0];

    jarak.value = (route['distance'] / 1000).toStringAsFixed(2); // km
    waktu.value = (route['duration'] / 60).toStringAsFixed(0); // menit
  }

  // 🚚 Simpan data pengiriman (simulasi)
  Future<void> kirimData() async {
    final data = {
      'pesanan_id': '1', // sesuaikan kalau dinamis
      'latitude_asal': latAsal.value,
      'longitude_asal': longAsal.value,
      'latitude_tujuan': latTujuan.value,
      'longitude_tujuan': longTujuan.value,
      'alamat_asal': alamatAsal.value,
      'alamat_tujuan': alamatTujuan.value,
      'jarak': jarak.value,
      'waktu_tempuh': waktu.value,
      'catatan': catatan.text,
    };

    debugPrint('Data yang akan dikirim: $data');
    // await deliveryService.kirimData(data); // jika ada
  }

  @override
  Future<void> onInit() async {
    super.onInit();

    final id = Get.parameters['orderId'];
    if (id != null) {
      final deliverys = await deliveryService.getDelivery(orderId: id);
      listDelivery.assignAll(deliverys);
    }
  }

  @override
  void onClose() {
    asalController.dispose();
    tujuanController.dispose();
    catatan.dispose();
    _debounceAsal?.cancel();
    _debounceTujuan?.cancel();
    super.onClose();
  }
}
