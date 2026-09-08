import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CstomDashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final String mainValue;
  final String? unit; // اختياري (مثل MWh)
  final Color mainValueColor;
  final String subtitle;
  final Color subtitleColor;

  const CstomDashboardCard({
    super.key,
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.mainValue,
    this.unit,
    this.mainValueColor = Colors.white,
    required this.subtitle,
    required this.subtitleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF191D24),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Header: Title + Icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(color: Colors.white24)),
              Icon(icon, color: iconColor, size: 24.sp),
            ],
          ),

          // Main Value + Unit (if any)
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                mainValue,
                style: TextStyle(
                  color: mainValueColor,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (unit != null) ...[
                const SizedBox(width: 8),
                Text(
                  unit!,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ],
          ),

          // Subtitle / Status Text
          Text(
            subtitle,
            style: TextStyle(
              color: subtitleColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
