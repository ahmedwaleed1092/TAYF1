import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tayf/core/theme/app_style.dart';

class LossCard extends StatelessWidget {
  final String title;
  final String value;
  final String unit;
  final String percentage;

  const LossCard({
    super.key,
    required this.title,
    required this.value,
    required this.unit,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xffFEF2F2),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        style: ListTileStyle.list,
        title: Text(
          title,
          style: AppStyle.headerTitle18ExtraBold.copyWith(
            fontSize: 18.sp,
            color: Color(0xffB91C1C),
          ),
        ),
        subtitle: Text(
          "$value $unit",
          style: AppStyle.headerTitle18ExtraBold.copyWith(
            fontSize: 22.sp,
            color: Color(0xffB91C1C),
          ),
        ),
        trailing: Text(
          "$percentage loss",
          style: AppStyle.headerTitle18ExtraBold.copyWith(
            fontSize: 14.sp,
            color: Color(0xffB91C1C),
          ),
        ),
      ),
    );
  }
}
