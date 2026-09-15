import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tayf/fetures/home/view/components/active_alert_card.dart';
import 'package:tayf/fetures/home/view/components/headline_title.dart';
import 'package:tayf/fetures/home/view/components/pannal_data_image.dart';
import 'package:tayf/fetures/home/view/components/peformance_card.dart';
import 'package:tayf/fetures/home/view/components/peformance_data.dart';

class BodyHomeScreen extends StatelessWidget {
  const BodyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15.h),
              headlineTitle(),
              Divider(
                color: Color(0xff242F41),
                thickness: 1,
                indent: 10.h,
                endIndent: 10.h,
              ),
              BannalData(),
              SizedBox(height: 16.h),
              PeformanceData(),
              SizedBox(height: 26.h),
              SizedBox(
                width: double.infinity,
                height: 250.h,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1,
                  ),

                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return PerformanceRatioCard(
                      title: "Current ",
                      value: "69 KWH",
                      width: 120.w,
                      height: 80.h,
                      peformanceNote: "22% lose",
                    );
                  },
                ),
              ),
              ActiveAlertsCard(
                alerts: [
                  const AlertItem(title: "Current Power", details: "69 KWH"),
                  const AlertItem(title: "Current Power", details: "69 KWH"),
                  const AlertItem(title: "Current Power", details: "69 KWH"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
