import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle {
  // Existing styles
  static TextStyle headerTitle20meduim = GoogleFonts.inter(
    fontSize: 20.sp,
    fontWeight: FontWeight.w500,
    color: Color(0xffF8F8F8),
  );

  static TextStyle headerTitle20Regular = GoogleFonts.inter(
    fontSize: 20.sp,
    fontWeight: FontWeight.w400,
    color: const Color(0xffE3DFDB),
    fontStyle: FontStyle.normal,
  );

  static TextStyle headerTitle14SimiBold = GoogleFonts.inter(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static TextStyle headerTitle40Bold = GoogleFonts.inter(
    fontSize: 40.sp,
    fontWeight: FontWeight.w700,
    color: const Color(0xffFAFAF9),
    fontStyle: FontStyle.normal,
  );

  // Onboarding-specific styles (white text for dark backgrounds)
  static TextStyle whiteBold28 = GoogleFonts.inter(
    fontSize: 28.sp,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static TextStyle whiteMedium16 = GoogleFonts.inter(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: Colors.white.withValues(alpha: 0.9),
    height: 1.5,
  );
}
