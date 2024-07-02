import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static Color primaryColorWhite = const Color(0xFFFFFFFF);
  static Color accentColorBlack = const Color(0xFF000000);

  static TextStyle baseTextStyle = GoogleFonts.nunito(
    textStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: accentColorBlack,
      decoration: TextDecoration.none,
    ),
  );
}
