import 'package:truck_track/app/data/api_client.dart';
import 'package:truck_track/app/models/jadwal_pengiriman.dart';
import 'package:truck_track/app/models/jadwal_pengiriman_driver.dart';

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

  Future<List<JadwalPengirimanDriver>> getJadwalPengirimanDriver() async {
    final response = await ApiClient.get('/jadwal-pengiriman/driver');

    // Parse the response data into a list of User objects
    final List<JadwalPengirimanDriver> jadwalPengiriman =
        (response!.data['data'] as List)
            .map((item) => JadwalPengirimanDriver.fromJson(item))
            .toList();

    return jadwalPengiriman;
  }

  Future<void> startDelivery(String idPesanan) async {
    final response = await ApiClient.post('/pengiriman/mulai/$idPesanan');
    return response?.data;
  }

  Future<void> addDeliveryNote(String idPengiriman, String note) async {
    final response = await ApiClient.post(
      '/pengiriman/catatan/$idPengiriman',
      data: {'catatan': note},
    );
    return response?.data;
  }

  Future<void> completeDelivery(String idPengiriman) async {
    final response = await ApiClient.post('/pengiriman/tandai-selesai/$idPengiriman');
    return response?.data;
  }
}
