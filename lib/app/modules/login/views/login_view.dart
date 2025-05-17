import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:truck_track/components/button.dart';
import 'package:truck_track/components/input.dart';
import 'package:truck_track/core/themes/themes.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: Themes.basePadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 160,
                  height: 160,
                ),
                Text(
                  'Selamat Datang di Aplikasi',
                  style: Themes.titleStyle.copyWith(
                    color: Themes.primaryColor,
                  ),
                ),
                Text(
                  'Silahkan login untuk melanjutkan',
                  style: Themes.bodyStyle,
                ),
              ],
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  InputField(title: 'Email'),
                  SizedBox(height: 20),
                  InputField(
                    title: 'Password',
                    hintText: 'Masukan kata sandi anda',
                  ),
                  SizedBox(height: 20),
                  Button(
                    title: 'Login',
                    onPressed: () {
                      Get.toNamed('/home');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
