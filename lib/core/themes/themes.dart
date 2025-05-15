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

  static Radius baseCardRadius = const Radius.circular(16);
  static BorderRadius baseButtonBorderRadius = BorderRadius.circular(8);
  static BorderRadius baseCardBorderRadius = BorderRadius.circular(16);

  static TextStyle baseTextStyle = GoogleFonts.plusJakartaSans().copyWith(
    overflow: TextOverflow.ellipsis,
    fontWeight: FontWeight.w100,
  );

  static TextStyle headingStyle = baseTextStyle.merge(
    GoogleFonts.plusJakartaSans().copyWith(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
  );

  static TextStyle titleStyle = baseTextStyle.merge(
    GoogleFonts.plusJakartaSans().copyWith(
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
  );

  static TextStyle bodyStyle = baseTextStyle.merge(
    GoogleFonts.plusJakartaSans().copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
  );
}
