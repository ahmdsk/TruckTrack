import 'package:flutter/material.dart';
import 'package:truck_track/core/themes/themes.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.title,
    this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.isFullWidth = true,
    this.bgColor,
    this.textColor,
    this.borderRadius,
  });

  final String title;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isDisabled;
  final bool isFullWidth;
  final Color? bgColor;
  final Color? textColor;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isDisabled ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor ?? Themes.primaryColor,
        disabledBackgroundColor: Themes.primaryColor.withAlpha(50),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(8),
        ),
        minimumSize: isFullWidth ? const Size(double.infinity, 50) : null,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      child:
          isLoading
              ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
              : Text(
                title,
                style: Themes.baseTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: textColor ?? Themes.whiteColor,
                ),
              ),
    );
  }
}
