import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:truck_track/app/data/api_client.dart';

class HomeController extends GetxController {
  var userData = {}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    try {
      final response = await ApiClient.dio.get('/me');
      userData.value = response.data;
    } catch (e) {
      debugPrint('Error fetching profile: $e');
    }
  }
}
