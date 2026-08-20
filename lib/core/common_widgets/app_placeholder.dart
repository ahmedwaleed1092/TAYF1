import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppPlaceholder extends StatelessWidget {
  final IconData icon;
  final String message;
  final Color color;

  const AppPlaceholder({
    super.key,
    required this.icon,
    required this.message,
    this.color = const Color(0xffAB9787),
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 72.sp, color: color.withAlpha((255 * 0.5).toInt())),
          SizedBox(height: 16.h),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              color: color.withAlpha((255 * 0.8).toInt()),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
