import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tayf/core/common_widgets/main_elevated_button.dart';
import 'package:tayf/core/theme/app_style.dart';
import 'package:tayf/fetures/home/cubit/wither_cubit.dart';

class BannalData extends StatelessWidget {
  const BannalData({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WitherCubit, WitherState>(
      builder: (context, state) {
        // Extract weather data when loaded
        String location = 'Beni Suef, Egypt';
        String temp = '--';
        String windDir = '--';

        if (state is WitherLoaded) {
          final weather = state.weatherModel;
          location = '${weather.location.name}, ${weather.location.country}';
          temp = '${weather.current.tempC.toStringAsFixed(0)}°C';
          windDir = weather.current.windDir;
        }

        return Stack(
          children: [
            Container(
              width: 345.w,
              height: 180.h,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.all(Radius.circular(16.r)),
                image: DecorationImage(
                  image: AssetImage("assets/images/planet1.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Temperature & Wind overlay (top-right)
            Positioned(
              right: 16,
              top: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    state is WitherLoading ? '...' : temp,
                    style: AppStyle.gray13Regular.copyWith(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.air, color: Colors.white70, size: 14.sp),
                      SizedBox(width: 4.w),
                      Text(
                        state is WitherLoading ? '...' : windDir,
                        style: AppStyle.gray10Regular.copyWith(
                          fontSize: 12.sp,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Online badge
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
            // Location info (bottom-left)
            Positioned(
              left: 20,
              bottom: 10,
              child: SizedBox(
                height: 45.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      state is WitherLoading ? 'Loading...' : location,
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
      },
    );
  }
}
