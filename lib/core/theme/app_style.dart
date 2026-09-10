import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tayf/core/theme/app_colors.dart';
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
  // Titles & Headers
  static TextStyle title = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryText,
  );

  static TextStyle sectionTitle = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryText,
  );

  // Body & Subtitles
  static TextStyle body = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.primaryText,
  );

  static TextStyle caption = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.secondaryText,
  );

  // Metric Values
  static TextStyle metricValue = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryText,
  );

  static TextStyle metricChange = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.positiveGreen,
  );
 static TextStyle precentageChange = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.negativeRed,
  );

}
