import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tayf/core/theme/app_style.dart';

class PlanetState extends StatelessWidget {
  final String? state;
  const PlanetState({super.key, this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SvgPicture.asset("assets/images/Vector.svg"),
            ),
            Text(
              "Plant State",
              style: AppStyle.gray10Regular.copyWith(
                fontSize: 14.sp,
                height: 1.5,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SvgPicture.asset("assets/images/peformingIcon.svg"),
            ),
            Text(
              state ?? "Underperforming",
              style: AppStyle.gray10Regular.copyWith(
                fontSize: 18.sp,
                height: 1.5,
                fontWeight: FontWeight.w700,
                color: const Color(0xffEA580C),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
