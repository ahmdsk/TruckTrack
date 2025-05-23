import 'package:flutter/foundation.dart';
import 'package:truck_track/app/data/api_client.dart';
import 'package:truck_track/app/models/kendaraan.dart';

class KendaraanService {
  Future<List<Kendaraan>> getKendaraan() async {
    final response = await ApiClient.dio.get('/kendaraan');

    // Parse the response data into a list of Kendaraan objects
    final List<Kendaraan> kendaraanList =
        (response.data['data'] as List)
            .map((item) => Kendaraan.fromJson(item))
            .toList();

    return kendaraanList;
  }

  Future<void> addKendaraan(Map<String, dynamic> data) async {
    debugPrint('Data yang dikirim: $data');
    final response = await ApiClient.post('/kendaraan', data: data);
    debugPrint('Response: ${response!.data}');
    return response.data;
  }
}
