import 'package:truck_track/app/data/api_client.dart';
import 'package:truck_track/app/models/pesanan.dart';

class DeliveryService {
  Future<List<Pesanan>> getPesanan() async {
    final response = await ApiClient.get('/pesanan');

    // Parse the response data into a list of User objects
    final List<Pesanan> userList =
        (response!.data['data'] as List)
            .map((item) => Pesanan.fromJson(item))
            .toList();

    return userList;
  }
}
