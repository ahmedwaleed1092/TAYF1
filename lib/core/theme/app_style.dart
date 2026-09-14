import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tayf/core/theme/app_fonts.dart';

class AppStyle {
  // Existing styles
  static TextStyle headerTitle18ExtraBold = AppFonts.inter.copyWith(
    fontSize: 22.sp,
    fontWeight: FontWeight.w700,
    color: const Color(0xff123B70),
  );

  static TextStyle gray10Regular = AppFonts.inter.copyWith(
    fontSize: 10.sp,
    fontWeight: FontWeight.w400,
    color: const Color(0xff64748B),
  );
  static TextStyle gray13Regular = AppFonts.inter.copyWith(
    fontSize: 13.sp,
    fontWeight: FontWeight.w500,
    color: const Color(0xff64748B),
  );

  // Onboarding-specific styles (white text for dark backgrounds)
  static TextStyle whiteBold28 = AppFonts.inter.copyWith(
    fontSize: 28.sp,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static TextStyle graySimiBold16 = AppFonts.inter.copyWith(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: Colors.grey,
    height: 1.5,
  );

  // ──────────────────────────────────────────────
  // Alert Screen – Common Colors
  // ──────────────────────────────────────────────
  static const Color alertTitleColor = Color(0xFF16326B);
  static const Color alertLabelColor = Color(0xFF6B7280);
  static const Color alertFilterSelectedColor = Color(0xFF16326B);
  static const Color alertFilterUnselectedTextColor = Color(0xFF8A93A3);
  static const Color alertFilterBackgroundColor = Color(0xFFF3F5F8);
  static const Color alertBottomNavInactiveColor = Color(0xFF9CA3AF);

  // ──────────────────────────────────────────────
  // Alert Screen – High Severity
  // ──────────────────────────────────────────────
  static const Color alertHighBackground = Color(0xFFFDEEEE);
  static const Color alertHighBorder = Color(0xFFF3C6C6);
  static const Color alertHighBadgeBg = Color(0xFFF6D9D9);
  static const Color alertHighBadgeText = Color(0xFFB71C1C);
  static const Color alertHighIconColor = Color(0xFFD32F2F);

  // ──────────────────────────────────────────────
  // Alert Screen – Medium Severity
  // ──────────────────────────────────────────────
  static const Color alertMediumBackground = Color(0xFFFDF6E3);
  static const Color alertMediumBorder = Color(0xFFEFE0B0);
  static const Color alertMediumBadgeBg = Color(0xFFF7E7B0);
  static const Color alertMediumBadgeText = Color(0xFF9A6B00);
  static const Color alertMediumIconColor = Color(0xFFE0A200);

  // ──────────────────────────────────────────────
  // Alert Screen – Info Severity
  // ──────────────────────────────────────────────
  static const Color alertInfoBackground = Color(0xFFE8F7EC);
  static const Color alertInfoBorder = Color(0xFFBFE8CC);
  static const Color alertInfoBadgeBg = Color(0xFFBFE8CC);
  static const Color alertInfoBadgeText = Color(0xFF1E8E3E);
  static const Color alertInfoIconColor = Color(0xFF1E8E3E);
}
