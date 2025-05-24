import 'package:flutter/material.dart';
import 'package:truck_track/core/themes/themes.dart';

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    required this.title,
    this.hintText,
    this.initialValue,
    this.largeText = false,
    this.controller,
    this.isPassword,
    this.keyboardType = TextInputType.text,
  });

  final String title;
  final String? hintText;
  final String? initialValue;
  final bool largeText;
  final TextEditingController? controller;
  final bool? isPassword;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Themes.subTitleStyle.copyWith(
            fontSize: 16,
            color: Themes.darkColor,
          ),
        ),
        SizedBox(height: 10),
        TextFormField(
          keyboardType: keyboardType,
          controller: controller,
          initialValue: initialValue,
          obscureText: isPassword ?? false,
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
          maxLines: largeText ? 4 : 1,
        ),
      ],
    );
  }
}
