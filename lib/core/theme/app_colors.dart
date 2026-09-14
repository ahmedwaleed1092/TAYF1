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

  // ──────────────────────────────────────────────
  // Soiling Analysis Screen
  // ──────────────────────────────────────────────
  static const Color soilingTitle = Color(0xFF16326B);
  static const Color soilingLabel = Color(0xFF6B7280);
  static const Color soilingLightBlueBg = Color(0xFFEAF3FB);
  static const Color soilingCardBorder = Color(0xFFE3E6EC);
  static const Color soilingCheckGreen = Color(0xFF1E8E3E);
  static const Color soilingTrendLine = Color(0xFF16326B);
  static const Color soilingGridLine = Color(0xFFE3E6EC);
  static const Color soilingAxisLabel = Color(0xFF9CA3AF);
  static const Color soilingNavInactive = Color(0xFF9CA3AF);

  // ──────────────────────────────────────────────
  // Alert Screen – Common
  // ──────────────────────────────────────────────
  static const Color alertTitle = Color(0xFF16326B);
  static const Color alertLabel = Color(0xFF6B7280);
  static const Color alertFilterSelected = Color(0xFF16326B);
  static const Color alertFilterUnselectedText = Color(0xFF8A93A3);
  static const Color alertFilterBackground = Color(0xFFF3F5F8);
  static const Color alertNavInactive = Color(0xFF9CA3AF);

  // Alert Screen – High Severity
  static const Color alertHighBackground = Color(0xFFFDEEEE);
  static const Color alertHighBorder = Color(0xFFF3C6C6);
  static const Color alertHighBadgeBg = Color(0xFFF6D9D9);
  static const Color alertHighBadgeText = Color(0xFFB71C1C);
  static const Color alertHighIcon = Color(0xFFD32F2F);

  // Alert Screen – Medium Severity
  static const Color alertMediumBackground = Color(0xFFFDF6E3);
  static const Color alertMediumBorder = Color(0xFFEFE0B0);
  static const Color alertMediumBadgeBg = Color(0xFFF7E7B0);
  static const Color alertMediumBadgeText = Color(0xFF9A6B00);
  static const Color alertMediumIcon = Color(0xFFE0A200);

  // Alert Screen – Info Severity
  static const Color alertInfoBackground = Color(0xFFE8F7EC);
  static const Color alertInfoBorder = Color(0xFFBFE8CC);
  static const Color alertInfoBadgeBg = Color(0xFFBFE8CC);
  static const Color alertInfoBadgeText = Color(0xFF1E8E3E);
  static const Color alertInfoIcon = Color(0xFF1E8E3E);

  // ──────────────────────────────────────────────
  // AI Copilot Chat Screen
  // ──────────────────────────────────────────────
  static const Color chatPrimary = Color(0xFF1E5FBF);
  static const Color chatUserBubble = Color(0xFF3D7BD9);
  static const Color chatBotBubble = Color(0xFFEAF1FB);
  static const Color chatBotText = Color(0xFF1B1F27);
  static const Color chatInputBg = Color(0xFFF0F2F5);
  static const Color chatActionBorder = Color(0xFFE1E6ED);
  static const Color chatActionIconBg = Color(0xFFE6F6EA);
  static const Color chatActionIconColor = Color(0xFF2E9E4F);
  static const Color chatBotAvatarBg = Color(0xFFEAF1FB);
  static const Color chatBotAvatarIcon = Color(0xFF3D7BD9);
  static const Color chatUserAvatarBg = Color(0xFFE1E6ED);
  static const Color chatUserAvatarIcon = Color(0xFF6B7280);
}
