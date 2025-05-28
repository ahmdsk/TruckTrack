import 'package:truck_track/app/data/api_client.dart';
import 'package:truck_track/app/models/jenis_kendaraan.dart';

class JenisKendaraanService {
  Future<List<JenisKendaraan>> getKendaraan() async {
    final response = await ApiClient.get('/jenis-kendaraan');

    // Parse the response data into a list of JenisKendaraan objects
    final List<JenisKendaraan> kendaraanList =
        (response!.data['data'] as List)
            .map((item) => JenisKendaraan.fromJson(item))
            .toList();

    return kendaraanList;
  }
}
