import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tayf/core/app_assets.dart';
import 'package:tayf/core/theme/app_style.dart';

class headlineTitle extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 28.h,
            width: 28.w,

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.r)),
            ),
            child: Image.asset(
              AppAssets.logo,
              fit: BoxFit.cover,
              width: 28.w,
              height: 28.h,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "TEYF",
                  style: AppStyle.headerTitle18ExtraBold.copyWith(
                    fontSize: 25.sp,
                  ),
                ),
                Text(
                  "Solar asset Decocion Intelligence",
                  style: AppStyle.gray10Regular,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
