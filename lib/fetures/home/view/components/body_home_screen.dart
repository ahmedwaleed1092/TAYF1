import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tayf/core/theme/app_style.dart';
import 'package:tayf/fetures/home/view/components/custom_card_dashboad.dart';
import 'package:tayf/fetures/home/view/components/system_statues_banner.dart';

class BodyHomeScreen extends StatelessWidget {
  const BodyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IntrinsicHeight(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "TEYF",
                    style: AppStyle.yellow22ExtraBold.copyWith(fontSize: 25.sp),
                  ),
                  VerticalDivider(
                    color: Color(0xff242F41),
                    thickness: 1,
                    indent: 10.h,
                    endIndent: 10.h,
                  ),
                  Text(
                    "Overview",
                    style: AppStyle.graySimiBold16.copyWith(
                      color: Colors.white,
                      fontSize: 22.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            color: Color(0xff242F41),
            thickness: 1,
            indent: 10.h,
            endIndent: 10.h,
          ),
          Text("Good Morning, Ahmed", style: AppStyle.graySimiBold16),
          Text(
            "Thursday, October 24, 2026",
            style: AppStyle.graySimiBold16.copyWith(
              color: Colors.grey,
              fontSize: 12.sp,
            ),
          ),
          SystemStatusBanner(
            subtitle: "All systems are running normally",
            title: "System Status",
          ),
          SizedBox(height: 10.h),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 10,
              childAspectRatio: 1.1,
            ),
            itemBuilder: (context, index) {
              return CstomDashboardCard(
                title: "Current Generation",
                icon: Icons.flash_on,
                iconColor: Colors.green,
                mainValue: "32",
                unit: "MWh",
                subtitle: "Last hour",
                subtitleColor: Colors.green,
              );
            },
            itemCount: 4,
          ),
        ],
      ),
    );
  }
}
