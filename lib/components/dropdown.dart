import 'package:flutter/material.dart';
import 'package:truck_track/core/themes/themes.dart';

class Dropdown<T> extends StatelessWidget {
  const Dropdown({
    super.key,
    required this.title,
    required this.items,
    this.hintText,
    this.value,
    this.onChanged,
  });

  final String title;
  final String? hintText;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;

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
        const SizedBox(height: 10),
        DropdownButtonFormField<T>(
          value: value,
          items: items,
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 20,
            ),
            hintText: hintText ?? 'Pilih $title',
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
