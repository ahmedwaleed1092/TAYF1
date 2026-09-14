import 'package:flutter/material.dart';
import 'package:tayf/core/theme/app_style.dart';

class PerformanceRatioCard extends StatelessWidget {
  final String title;
  final String value;
  final double width;
  final double height;
  final String? peformanceNote;

  const PerformanceRatioCard({
    super.key,
    required this.title,
    required this.value,
    required this.width,
    required this.height,
    this.peformanceNote,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE3E6EC), width: 1.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppStyle.gray13Regular.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF6B7280),
            ),
          ),
          Text(
            value,
            style: AppStyle.graySimiBold16.copyWith(
              color: const Color(0xFF123B70),
            ),
          ),
          Text(
            peformanceNote ?? "",
            style: AppStyle.graySimiBold16.copyWith(
              fontSize: 10,
              color: const Color(0xFFDC2626),
            ),
          ),
        ],
      ),
    );
  }
}
