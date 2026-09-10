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
}
