import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class Themes {
  static Color whiteColor = const Color(0xFFFFFFFF);
  static Color darkColor = const Color(0xFF26273A);
  static Color secondaryColor = const Color(0xFFF6F8FA);
  static Color primaryColor = const Color(0xFFE87015);
  static Color successColor = const Color(0xFF5DC486);
  static Color dangerColor = const Color(0xFFF54B5F);

  static Color scaffoldBackgroundColor = const Color(0xFFF6F8FA);

  static Color whiteBorderColor = const Color(0xFFE0E8F2);

  static AppBarTheme appBarTheme = AppBarTheme(
    centerTitle: true,
    backgroundColor: Themes.whiteColor,
    titleTextStyle: Themes.baseTextStyle.copyWith(
      color: Themes.darkColor,
      fontSize: 16,
    ),
    elevation: 0,
  );

  static EdgeInsets basePadding = const EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 10,
  );

  static Radius baseCardRadius = const Radius.circular(16);
  static BorderRadius baseButtonBorderRadius = BorderRadius.circular(8);
  static BorderRadius baseCardBorderRadius = BorderRadius.circular(16);

  // Style Font
  static TextStyle _style({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
  }) {
    return GoogleFonts.plusJakartaSans(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    ).copyWith(overflow: TextOverflow.ellipsis);
  }

  static final baseTextStyle = _style(fontWeight: FontWeight.w400);

  static final titleStyle = _style(
    fontSize: 24,
    fontWeight: FontWeight.w800,
    color: Themes.darkColor,
  );

  static final subTitleStyle = _style(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Themes.darkColor,
  );

  static final bodyStyle = _style(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Themes.darkColor,
  );
}
