import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:tayf/core/common_widgets/main_elevated_button.dart';
import 'package:tayf/fetures/home/view/components/planet_state.dart';

class PeformanceData extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360.w,
      height: 85.h,
      decoration: BoxDecoration(
        color: Color(0xffFFF7ED),
        borderRadius: BorderRadius.all(Radius.circular(16.r)),
        border: Border.all(color: Colors.black, width: 1.w),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PlanetState(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: CircularPercentIndicator(
                  radius: 20.r,
                  lineWidth: 5,
                  animation: true,
                  percent: 0.75,
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: Color(0xFF9663EC),
                  backgroundColor: Color(0xffFFF7ED),
                  center: Text("75%"),
                ),
              ),
              MainElevatedButton(
                width: 15,
                height: 25,
                textOnButton: "View Details",
                backgroundColor: Color(0xFF9663EC),
                textColor: Colors.white,
                textFontSize: 12,
                onButtonTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
