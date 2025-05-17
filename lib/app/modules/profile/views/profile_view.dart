import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:truck_track/components/button.dart';
import 'package:truck_track/components/input.dart';
import 'package:truck_track/core/themes/themes.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile Saya',
          style: Themes.subTitleStyle.copyWith(
            color: Themes.darkColor,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/profile-pict.jpg'),
            ),
            // Column Name with label and value
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Jhon Doe',
                  style: Themes.titleStyle.copyWith(color: Themes.primaryColor),
                ),
                Text(
                  'Manajer',
                  style: Themes.subTitleStyle.copyWith(
                    color: Themes.darkColor,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            InputField(
              title: 'Email',
              hintText: 'Masukkan email anda',
              initialValue: 'admin@gmail.com',
            ),
            const SizedBox(height: 20),
            InputField(
              title: 'No. Telp',
              hintText: 'Masukkan no. telp anda',
              initialValue: '081234567890',
            ),
            const SizedBox(height: 20),
            InputField(
              title: 'Alamat',
              hintText: 'Masukkan alamat anda',
              initialValue: 'Jl. Raya No. 123, Jakarta',
              largeText: true,
            ),
            const SizedBox(height: 20),
            Button(
              title: 'Simpan',
              onPressed: () {
                debugPrint('Simpan Profile');
              },
            ),
          ],
        ),
      ),
    );
  }
}
