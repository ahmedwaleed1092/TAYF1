import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tayf/core/theme/app_fonts.dart';

class AppStyle {
  // Existing styles
  static TextStyle yellow22ExtraBold = AppFonts.geist.copyWith(
    fontSize: 22.sp,
    fontWeight: FontWeight.w800,
    color: const Color(0xffF59E0B),
  );

  static TextStyle gray22Regular = AppFonts.geist.copyWith(
    fontSize: 22.sp,
    fontWeight: FontWeight.w500,
    color: const Color(0xffF59E0B),
  );

  static TextStyle headerTitle18Bold = AppFonts.geist.copyWith(
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
    color: const Color(0xffF9FAFB),
  );

  // Onboarding-specific styles (white text for dark backgrounds)
  static TextStyle whiteBold28 = AppFonts.geist.copyWith(
    fontSize: 28.sp,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static TextStyle graySimiBold16 = AppFonts.geist.copyWith(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: Colors.grey,
    height: 1.5,
  );
}
