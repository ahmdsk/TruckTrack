import 'package:truck_track/app/data/api_client.dart';
import 'package:truck_track/app/models/jadwal_pengiriman.dart';

class JadwalPengirimanService {
  Future<List<JadwalPengiriman>> getAllJadwalPengiriman() async {
    final response = await ApiClient.get('/jadwal-pengiriman');

    // Parse the response data into a list of User objects
    final List<JadwalPengiriman> jadwalPengiriman =
        (response!.data['data'] as List)
            .map((item) => JadwalPengiriman.fromJson(item))
            .toList();

    return jadwalPengiriman;
  }
}
