import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:truck_track/%20components/button.dart';
import 'package:truck_track/core/themes/themes.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
                  style: Themes.headingStyle.copyWith(
                    color: Themes.primaryColor,
                    fontWeight: FontWeight.w600,
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
                      debugPrint('Login button pressed');
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

class InputField extends StatelessWidget {
  const InputField({super.key, required this.title, this.hintText});

  final String title;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Themes.bodyStyle.copyWith(
            fontSize: 16,
            color: Themes.darkColor,
          ),
        ),
        SizedBox(height: 10),
        TextFormField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 20,
            ),
            hintText: hintText ?? 'Masukkan $title',
            hintStyle: Themes.baseTextStyle.copyWith(
              fontSize: 14,
              color: Themes.darkColor,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: Themes.baseButtonBorderRadius,
              borderSide: BorderSide(
                color: Themes.primaryColor.withAlpha(70),
                width: 2,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: Themes.baseButtonBorderRadius,
              borderSide: BorderSide(
                color: Themes.primaryColor.withAlpha(70),
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: Themes.baseButtonBorderRadius,
              borderSide: BorderSide(
                color: Themes.primaryColor.withAlpha(80),
                width: 3,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
