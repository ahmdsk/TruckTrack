import 'package:truck_track/app/data/api_client.dart';
import 'package:truck_track/app/models/jenis_bbm.dart';

class JenisBBMService {
  Future<List<JenisBbm>> getAllJenisBBM() async {
    final response = await ApiClient.get('/jenis-bbm');

    // Parse the response data into a list of JenisBbm objects
    final List<JenisBbm> listBBM =
        (response!.data['data'] as List)
            .map((item) => JenisBbm.fromJson(item))
            .toList();

    return listBBM;
  }
}
