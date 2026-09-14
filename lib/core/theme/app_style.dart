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

  // ──────────────────────────────────────────────
  // Alert Screen – Color Aliases (backward-compatible)
  // ──────────────────────────────────────────────
  static const Color alertTitleColor = AppColors.alertTitle;
  static const Color alertLabelColor = AppColors.alertLabel;
  static const Color alertFilterSelectedColor = AppColors.alertFilterSelected;
  static const Color alertFilterUnselectedTextColor = AppColors.alertFilterUnselectedText;
  static const Color alertFilterBackgroundColor = AppColors.alertFilterBackground;
  static const Color alertBottomNavInactiveColor = AppColors.alertNavInactive;

  static const Color alertHighBackground = AppColors.alertHighBackground;
  static const Color alertHighBorder = AppColors.alertHighBorder;
  static const Color alertHighBadgeBg = AppColors.alertHighBadgeBg;
  static const Color alertHighBadgeText = AppColors.alertHighBadgeText;
  static const Color alertHighIconColor = AppColors.alertHighIcon;

  static const Color alertMediumBackground = AppColors.alertMediumBackground;
  static const Color alertMediumBorder = AppColors.alertMediumBorder;
  static const Color alertMediumBadgeBg = AppColors.alertMediumBadgeBg;
  static const Color alertMediumBadgeText = AppColors.alertMediumBadgeText;
  static const Color alertMediumIconColor = AppColors.alertMediumIcon;

  static const Color alertInfoBackground = AppColors.alertInfoBackground;
  static const Color alertInfoBorder = AppColors.alertInfoBorder;
  static const Color alertInfoBadgeBg = AppColors.alertInfoBadgeBg;
  static const Color alertInfoBadgeText = AppColors.alertInfoBadgeText;
  static const Color alertInfoIconColor = AppColors.alertInfoIcon;

  // ──────────────────────────────────────────────
  // Alert Screen – Text Styles
  // ──────────────────────────────────────────────
  static TextStyle alertAppBarTitle = AppFonts.inter.copyWith(
    fontSize: 19.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.alertTitle,
  );

  static TextStyle alertCardTitle = AppFonts.inter.copyWith(
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.alertTitle,
  );

  static TextStyle alertBadgeLabel = AppFonts.inter.copyWith(
    fontSize: 11.sp,
    fontWeight: FontWeight.bold,
  );

  static TextStyle alertFilterTab = AppFonts.inter.copyWith(
    fontSize: 13.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle alertInfoLineLabel = AppFonts.inter.copyWith(
    fontSize: 13.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.alertLabel,
  );

  static TextStyle alertInfoLineValue = AppFonts.inter.copyWith(
    fontSize: 13.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.alertTitle,
  );

  static TextStyle alertNormalText = AppFonts.inter.copyWith(
    fontSize: 13.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.alertLabel,
  );

  static TextStyle alertEmptyText = AppFonts.inter.copyWith(
    fontSize: 14.sp,
    color: AppColors.alertLabel,
  );

  static TextStyle alertNavLabel = AppFonts.inter.copyWith(
    fontSize: 10.5.sp,
    color: AppColors.alertNavInactive,
  );

  // ──────────────────────────────────────────────
  // Soiling Analysis Screen
  // ──────────────────────────────────────────────
  static TextStyle soilingAppBarTitle = AppFonts.inter.copyWith(
    fontSize: 19.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.soilingTitle,
  );

  static TextStyle soilingSectionTitle = AppFonts.inter.copyWith(
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.soilingTitle,
  );

  static TextStyle soilingCardTitle = AppFonts.inter.copyWith(
    fontSize: 15.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.soilingTitle,
  );

  static TextStyle soilingBannerTitle = AppFonts.inter.copyWith(
    fontSize: 14.5.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.soilingTitle,
  );

  static TextStyle soilingBannerSubtitle = AppFonts.inter.copyWith(
    fontSize: 12.5.sp,
    color: AppColors.soilingLabel,
  );

  static TextStyle soilingStatLabel = AppFonts.inter.copyWith(
    fontSize: 13.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.soilingLabel,
  );

  static TextStyle soilingStatValue = AppFonts.inter.copyWith(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.soilingTitle,
  );

  static TextStyle soilingInputLabel = AppFonts.inter.copyWith(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.soilingTitle,
  );

  static TextStyle soilingImpactLabel = AppFonts.inter.copyWith(
    fontSize: 12.5.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.soilingLabel,
  );

  static TextStyle soilingImpactValue = AppFonts.inter.copyWith(
    fontSize: 17.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.soilingTitle,
  );

  static TextStyle soilingButtonText = AppFonts.inter.copyWith(
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static TextStyle soilingNavLabel = AppFonts.inter.copyWith(
    fontSize: 10.5.sp,
    color: AppColors.soilingNavInactive,
  );

  // ──────────────────────────────────────────────
  // AI Copilot Chat Screen
  // ──────────────────────────────────────────────
  static TextStyle chatAppBarTitle = AppFonts.inter.copyWith(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.chatPrimary,
  );

  static TextStyle chatBotMessage = AppFonts.inter.copyWith(
    fontSize: 15.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.chatBotText,
    height: 1.35,
  );

  static TextStyle chatUserMessage = AppFonts.inter.copyWith(
    fontSize: 15.sp,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    height: 1.35,
  );

  static TextStyle chatTimestamp = AppFonts.inter.copyWith(
    fontSize: 12.sp,
    color: Colors.grey,
  );

  static TextStyle chatActionLabel = AppFonts.inter.copyWith(
    fontSize: 11.sp,
    color: Colors.grey,
  );

  static TextStyle chatActionTitle = AppFonts.inter.copyWith(
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.chatBotText,
  );

  static TextStyle chatSuggestedHeader = AppFonts.inter.copyWith(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.chatPrimary,
  );

  static TextStyle chatSuggestedChip = AppFonts.inter.copyWith(
    fontSize: 13.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.chatPrimary,
  );
}
