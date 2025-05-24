import 'package:truck_track/app/data/api_client.dart';
import 'package:truck_track/app/models/cek_pesanan_costumer.dart';
import 'package:truck_track/app/models/pesanan.dart';

class OrderService {
  Future<List<Pesanan>> getPesanan() async {
    final response = await ApiClient.get('/pesanan');

    // Parse the response data into a list of User objects
    final List<Pesanan> userList =
        (response!.data['data'] as List)
            .map((item) => Pesanan.fromJson(item))
            .toList();

    return userList;
  }

  Future<void> addPesanan(Map<String, dynamic> data) async {
    final response = await ApiClient.post('/pesanan', data: data);
    return response!.data;
  }

  Future<void> updatePesanan(String id, Map<String, dynamic> data) async {
    final response = await ApiClient.put('/pesanan/$id', data: data);
    return response!.data;
  }

  Future<void> deletePesanan(String id) async {
    final response = await ApiClient.delete('/pesanan/$id');
    return response!.data;
  }  

  Future<List<CekPesananCostumer>> getCekPesananCostumer(String costumerId) async {
    final response = await ApiClient.get('/pesanan/costumer/$costumerId');

    // Parse the response data into a list of CekPesananCostumer objects
    final List<CekPesananCostumer> cekPesananList =
        (response!.data['data'] as List)
            .map((item) => CekPesananCostumer.fromJson(item))
            .toList();

    return cekPesananList;
  }
}
