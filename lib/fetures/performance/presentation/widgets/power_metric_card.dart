import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:tayf/core/theme/app_colors.dart';
import 'package:tayf/core/theme/app_style.dart';

class PowerMetricsCard extends StatelessWidget {
  final String currentPowerValue;
  final String expectedPowerValue;
  final double percentage;
  final Color? backgroundColor;
  final VoidCallback? onViewDetails;

  const PowerMetricsCard({
    super.key,
    required this.currentPowerValue,
    required this.expectedPowerValue,
    required this.percentage,
    this.backgroundColor,
    this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. Current Power Section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Current power',
                      style: AppStyle.caption,
                    ),
                    const Gap(12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          currentPowerValue,
                          style: AppStyle.metricValue,
                        ),
                        const Gap(4),
                        Text(
                          'KW',
                          style: AppStyle.sectionTitle,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // 2. Vertical Divider
            const VerticalDivider(
              color: AppColors.border,
              thickness: 1,
              width: 1,
            ),

            // 3. Expected Power Section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Expected Power',
                          style: AppStyle.caption,
                        ),
                        const Gap(12),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              expectedPowerValue,
                              style: AppStyle.metricValue,
                            ),
                            const Gap(4),
                            Text(
                              'KW',
                              style: AppStyle.sectionTitle,
                            ),
                            const Gap(8),
                            Text(
                              '${percentage.abs().toStringAsFixed(1)}%',
                              style: AppStyle.precentageChange,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Gap(12),
                    // View Details Button
                    InkWell(
                      onTap: onViewDetails,
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.border, width: 1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Text(
                            'View Details',
                            style: TextStyle(
                              color: Color(0xFF0F2B48), // عدل اللون حسب AppStyle المناسب
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}