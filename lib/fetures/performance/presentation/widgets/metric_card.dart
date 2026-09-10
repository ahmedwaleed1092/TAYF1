import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:tayf/core/theme/app_colors.dart';
import 'package:tayf/core/theme/app_style.dart';

class MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String changePercentage;
  final bool isPositive;

  const MetricCard({
    super.key,
    required this.title,
    required this.value,
    required this.changePercentage,
    this.isPositive = true,
  });

  @override
  Widget build(BuildContext context) {
    final changeColor = isPositive ? AppColors.positiveGreen : AppColors.negativeRed;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.border.withValues(alpha: 0.6),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppStyle.caption.copyWith(
                color: AppColors.secondaryText,
                fontSize: 15,
              ),
            ),
            const Gap(8),
            Text(
              value,
              textAlign: TextAlign.center,
              style: AppStyle.caption.copyWith(
                color: AppColors.primaryText,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(8),
            Text(
              changePercentage,
              style: AppStyle.caption.copyWith(
                color: changeColor,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}