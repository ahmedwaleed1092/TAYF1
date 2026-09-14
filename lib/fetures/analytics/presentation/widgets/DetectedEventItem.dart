import 'package:flutter/material.dart';
import 'package:tayf/core/theme/app_colors.dart';
import 'package:tayf/core/theme/app_style.dart';

enum EventSeverity { high, low }

class DetectedEventItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final EventSeverity severity;

  const DetectedEventItem({
    super.key,
    required this.title,
    required this.subtitle,
    this.severity = EventSeverity.high,
  });

  @override
  Widget build(BuildContext context) {
    final isHigh = severity == EventSeverity.high;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.border,
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Icon(
            Icons.warning_amber_rounded,
            color: isHigh ? const Color(0xFFEAB308) : AppColors.positiveGreen,
            size: 28,
          ),
          const SizedBox(width: 12),

          // Titles
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppStyle.caption.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  )

                      ),

                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: isHigh
                        ? AppColors.secondaryText
                        : AppColors.positiveGreen,
                  ),
                ),
              ],
            ),
          ),

          // Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: isHigh ? const Color(0xFFFFF0F0) : const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              isHigh ? 'High' : 'Low',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isHigh ? AppColors.negativeRed : AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}