import 'package:flutter/material.dart';

class Pallete {
  static const Color backround = Color(0xFFF5F5F4);
  static const Color secondaryBackround = Color(0xFFE9E9E9);
  static const Color primary = Color(0xFFFFFFFF);
  static const Color primaryVariant = Color(0xFFF5F5F4);
  static const Color secondary = Color(0xFF110A04);
  static const Color secondaryVariant = Color(0xFF37312C);
  static const Color accent = Color(0xFF337D5C);
}

class AppThemes {
  // all the application themes would be written here
  static ThemeData normalTheme = ThemeData(
    accentColor: Pallete.accent,
    primaryColor: Pallete.primary,
    backgroundColor: Pallete.secondaryBackround,
    //fontFamily: GoogleFonts.montserrat().fontFamily,
    fontFamily: 'Montserrat',
    // textTheme: GoogleFonts.montserratTextTheme(),
    iconTheme: IconThemeData(color: Pallete.secondaryVariant),
    indicatorColor: Pallete.accent,
  );
}
