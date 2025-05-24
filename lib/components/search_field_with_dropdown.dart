import 'package:flutter/material.dart';
import 'package:truck_track/core/themes/themes.dart';

class SearchFieldWithDropdown extends StatelessWidget {
  const SearchFieldWithDropdown({
    super.key,
    required this.title,
    required this.controller,
    required this.onChanged,
    required this.suggestions,
    required this.onSuggestionTap,
    this.hintText,
  });

  final String title;
  final TextEditingController controller;
  final Function(String) onChanged;
  final List<dynamic> suggestions;
  final Function(String) onSuggestionTap;
  final String? hintText;

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
        Stack(
          children: [
            TextFormField(
              controller: controller,
              onChanged: onChanged,
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
            if (suggestions.isNotEmpty)
              SizedBox(
                height: 200,
                child: Stack(
                  children: [
                    Positioned(
                      top: 60,
                      left: 0,
                      right: 0,
                      child: Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(8),
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: suggestions.length,
                          itemBuilder: (context, index) {
                            final suggestion = suggestions[index];
                            return ListTile(
                              title: Text(suggestion),
                              onTap: () => onSuggestionTap(suggestion),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }
}
