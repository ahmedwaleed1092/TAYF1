import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tayf/core/common_widgets/main_elevated_button.dart';
import 'package:tayf/core/theme/app_style.dart';

class BannalData extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 345.w,
          height: 180.h,
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.all(Radius.circular(16.r)),
            image: DecorationImage(
              image: AssetImage("assets/images/pannal.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          right: 20,
          bottom: 10,
          child: MainElevatedButton(
            textOnButton: "Online",
            textColor: Color(0xff15803D),
            backgroundColor: Color(0xffDCFCE7),
            onButtonTap: () {},
            width: 50.w,
            height: 22.h,
          ),
        ),
        Positioned(
          left: 20,
          bottom: 10,
          child: SizedBox(
            height: 45.h,
            child: Column(
              children: [
                Text(
                  "Andasol-3 Solar Plant",
                  style: AppStyle.gray13Regular.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                  ),
                ),
                Text(
                  "Beni Suef , Egypt",
                  style: AppStyle.gray10Regular.copyWith(
                    fontSize: 12.sp,
                    color: Colors.white,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
