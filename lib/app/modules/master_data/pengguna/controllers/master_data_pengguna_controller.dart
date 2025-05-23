import 'package:get/get.dart';
import 'package:truck_track/app/models/user.dart';
import 'package:truck_track/service_locator.dart';
import 'package:truck_track/services/user_service.dart';

class MasterDataPenggunaController extends GetxController {
  final listUsers = <User>[].obs;

  final userService = sl<UserService>();

  @override
  Future<void> onInit() async {
    super.onInit();

    final users = await userService.getAllByRoles(UserRole.driver);
    listUsers.assignAll(users);
  }
}
