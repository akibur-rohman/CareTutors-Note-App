import 'package:flutter/material.dart';

class AppSpacing {
  AppSpacing._();

  // Spacing / Margins
  static const double base = 4.0;
  static const double xs = 8.0;
  static const double sm = 16.0;
  static const double md = 24.0;
  static const double lg = 40.0;
  static const double xl = 64.0;
  static const double gutter = 16.0;
  static const double marginMobile = 16.0;
  static const double marginDesktop = 48.0;

  // Neo-Brutalist Sharp Shape Radii (Strictly 0px)
  static const double radiusSm = 0.0;
  static const double radiusDefault = 0.0;
  static const double radiusMd = 0.0;
  static const double radiusCard = 0.0;
  static const double radiusLg = 0.0;
  static const double radiusXl = 0.0;
  static const double radiusFull = 0.0;

  // Solid Outlines
  static const double borderThicknessThin = 1.0;
  static const double borderThicknessMedium = 2.0;
  static const double borderThicknessThick = 3.0;

  // Tactile Shadows (Hard solid offset, no blurs)
  static const List<BoxShadow> level1Shadow = [
    BoxShadow(
      color: Color(0xFF000000),
      blurRadius: 0.0,
      spreadRadius: 0.0,
      offset: Offset(2, 2),
    ),
  ];

  static const List<BoxShadow> level2Shadow = [
    BoxShadow(
      color: Color(0xFF000000),
      blurRadius: 0.0,
      spreadRadius: 0.0,
      offset: Offset(4, 4),
    ),
  ];

  static const List<BoxShadow> level3Shadow = [
    BoxShadow(
      color: Color(0xFF000000),
      blurRadius: 0.0,
      spreadRadius: 0.0,
      offset: Offset(6, 6),
    ),
  ];
}
