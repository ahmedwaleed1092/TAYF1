import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:tayf/core/theme/app_colors.dart';
import 'package:tayf/core/theme/app_style.dart';

class PowerComparisonSummaryCard extends StatelessWidget {
  final String expectedPower;
  final String actualPower;
  final String deviation;

  const PowerComparisonSummaryCard({
    super.key,
    required this.expectedPower,
    required this.actualPower,
    required this.deviation,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F7FA),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 1. Expected Power
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Expected Power',
                    style: AppStyle.caption,
                  ),
                  const Gap(12),
                  Text(
                    '$expectedPower KW',
                    style: AppStyle.metricValue,
                  ),
                ],
              ),
            ),

            // 2. Actual Power
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Actual Power',
                    style: AppStyle.caption,
                  ),
                  const Gap(12),
                  Text(
                    '$actualPower KW',
                    style: AppStyle.metricValue,
                  ),
                ],
              ),
            ),

            // 3. Deviation
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Deviation',
                    style: AppStyle.caption,
                  ),
                  const Gap(12),
                  Text(
                    deviation,
                    style: AppStyle.precentageChange.copyWith(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
