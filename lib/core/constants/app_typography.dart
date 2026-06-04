import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  AppTypography._();

  static TextStyle get displayLg => GoogleFonts.spaceGrotesk(
        fontSize: 48.0,
        fontWeight: FontWeight.w700,
        height: 1.1,
        letterSpacing: -0.02 * 48.0,
      );

  static TextStyle get displayLgMobile => GoogleFonts.spaceGrotesk(
        fontSize: 32.0,
        fontWeight: FontWeight.w700,
        height: 1.1,
        letterSpacing: -0.02 * 32.0,
      );

  static TextStyle get headlineLg => GoogleFonts.spaceGrotesk(
        fontSize: 32.0,
        fontWeight: FontWeight.w700,
        height: 1.2,
      );

  static TextStyle get headlineLgMobile => GoogleFonts.spaceGrotesk(
        fontSize: 24.0,
        fontWeight: FontWeight.w700,
        height: 1.2,
      );

  // Body copy and functional labels use Space Mono
  static TextStyle get bodyLg => GoogleFonts.spaceMono(
        fontSize: 18.0,
        fontWeight: FontWeight.w400,
        height: 1.6,
      );

  static TextStyle get bodyMd => GoogleFonts.spaceMono(
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        height: 1.6,
      );

  static TextStyle get bodySm => GoogleFonts.spaceMono(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        height: 1.6,
      );

  static TextStyle get labelMd => GoogleFonts.spaceMono(
        fontSize: 14.0,
        fontWeight: FontWeight.w700,
        height: 1.2,
      );

  static TextStyle get labelSm => GoogleFonts.spaceMono(
        fontSize: 12.0,
        fontWeight: FontWeight.w400,
        height: 1.2,
      );

  static TextStyle get caption => GoogleFonts.spaceMono(
        fontSize: 12.0,
        fontWeight: FontWeight.w400,
        height: 1.2,
      );
}
