import 'package:flutter/material.dart';
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

  Future<void> addUser(Map<String, dynamic> user) async {
    final response = await ApiClient.post('/users', data: user);
    debugPrint('Response: ${response!.data}, Data yang dikirim: $user');
    return response.data;
  }

  Future<void> deleteUser(String id) async {
    final response = await ApiClient.delete('/users/$id');
    return response!.data;
  }

  Future<void> updateUser(String id, Map<String, dynamic> user) async {
    final response = await ApiClient.put('/users/$id', data: user);
    return response!.data;
  }
}
