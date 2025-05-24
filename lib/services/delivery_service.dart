import 'package:truck_track/app/data/api_client.dart';
import 'package:truck_track/app/models/tujuan_kirim.dart';

class DeliveryService {
  Future<List<TujuanKirim>> getDelivery({required String orderId}) async {
    final response = await ApiClient.get('/tujuan-kirim/pesanan/$orderId');

    // Parse the response data into a list of User objects
    final List<TujuanKirim> userList =
        (response!.data['data'] as List)
            .map((item) => TujuanKirim.fromJson(item))
            .toList();

    return userList;
  }

  Future<void> addDelivery(Map<String, dynamic> data) async {
    final response = await ApiClient.post('/tujuan-kirim', data: data);
    return response!.data;
  }

  Future<void> updateDelivery(String id, Map<String, dynamic> data) async {
    final response = await ApiClient.put('/tujuan-kirim/$id', data: data);
    return response!.data;
  }

  Future<void> deleteDelivery(String id) async {
    final response = await ApiClient.delete('/tujuan-kirim/$id');
    return response!.data;
  }  
}
