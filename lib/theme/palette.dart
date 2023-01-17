import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Palette {
  static const Color kDarkBackgroundColor = Color(0xFF2a2222);
  static const Color kLightButtonColor = Color(0xFF284bc1);
  static const Color kLightThemeColor = Color(0xFF333e97);
  static const Color kLightThemeColorAccent = Color(0xFF7b85cf);
  static const Color kLightSelectedColor = Color(0xFFea4d90);
  static const Color kDarkGreyColor = Color(0xFF121212);
}

class Themes {
  static final light = ThemeData(
    primaryColor: Palette.kLightThemeColor,
    brightness: Brightness.light,
    textTheme: GoogleFonts.lexendTextTheme(),
  );

  static final dark = ThemeData(
    primaryColor: Palette.kDarkGreyColor,
    brightness: Brightness.dark,
    textTheme: GoogleFonts.lexendTextTheme(),
  );
}
