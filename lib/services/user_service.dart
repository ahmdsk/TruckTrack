import 'package:truck_track/app/data/api_client.dart';
import 'package:truck_track/app/models/user.dart';

enum UserRole {
  admin,
  driver,
  costumer,
}

class UserService {
  Future<List<User>> getAllByRoles(UserRole role) async {
    final response = await ApiClient.get('/users/${role.name}');

    // Parse the response data into a list of User objects
    final List<User> userList =
        (response!.data['data'] as List)
            .map((item) => User.fromJson(item))
            .toList();

    return userList;
  }
}
