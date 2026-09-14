import 'package:flutter/material.dart';

/// Color palette extracted from Figma "Color Styles" frame.
/// Source: Mobile App Design (kL8feVVKQxhH7P6gnnW0hk)
class AppColors {
  AppColors._();

  // Primary
  static const Color primary = Color(0xFF3380CC); // 51,128,204
  static const Color primaryVariant = Color(0xFF408CD9); // 64,140,217
  static const Color primaryContrast = Color(0xFFFFFFFF); // 255,255,255

  // Secondary
  static const Color secondary = Color(0xFFE6B333); // 230,179,51
  static const Color secondaryVariant = Color(0xFFF2BF40); // 242,191,64
  static const Color secondaryContrast = Color(0xFF000000); // 0,0,0

  // Semantic
  static const Color accent = Color(0xFF1AB380); // 26,179,128
  static const Color success = Color(0xFF33B34D); // 51,179,77
  static const Color warning = Color(0xFFE69933); // 230,153,51
  static const Color error = Color(0xFFCC3333); // 204,51,51
  static const Color info = Color(0xFF3380CC); // 51,128,204

  // Surfaces
  static const Color background = Color(0xFF1A1A1F); // 26,26,31
  static const Color surface = Color(0xFF26262E); // 38,38,46
  static const Color divider = Color(0xFF333340); // 51,51,64

  // On-colors (content drawn on top of the colors above)
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onSecondary = Color(0xFF000000);
  static const Color onSurface = Color(0xFFE6E6E6); // 230,230,230
  static const Color onBackground = Color(0xFFE6E6E6); // 230,230,230

  // States
  static const Color disabled = Color(0xFF808080); // 128,128,128
  static const Color placeholder = Color(0xFF999999); // 153,153,153

  // Main Colors
  //static const Color primary = Color(0xFF1D35C2);
  //  static const Color background = Color(0xFFF8F9FA);
  static const Color cardBackground = Color(0xFFF8FAFC);

  // Text Colors
  static const Color primaryText = Color(0xFF0D2247);
  static const Color secondaryText = Color(0xFF6C757D);

  // Status Colors
  static const Color positiveGreen = Color(0xFF2E7D32);
  static const Color negativeRed = Color(0xFFD32F2F);

  // Borders & Dividers
  static const Color border = Color(0xFFE2E8F0);

  // Chart Colors
  static const Color chartLine = Color(0xFF2A2A2A);
  static const Color chartBar = Color(0xFF2196F3);
}
