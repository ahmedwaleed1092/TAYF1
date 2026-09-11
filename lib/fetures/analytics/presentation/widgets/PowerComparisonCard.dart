import 'package:flutter/material.dart';
import 'package:tayf/core/theme/app_colors.dart';
import 'package:tayf/core/theme/app_style.dart';
import 'package:tayf/fetures/performance/presentation/widgets/power_chart_widget.dart';

class PowerComparisonCard extends StatelessWidget {
  final List<String>? timeLabels;

  const PowerComparisonCard({
    super.key,
    this.timeLabels,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Section Title
            Text(
              'Power Comparison',
              style: AppStyle.sectionTitle.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: const Color(0xFF0F2B48),
              ),
            ),
            const SizedBox(height: 8),
      
            // 2. Legend Right-Aligned (Right above the chart grid)
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '-- Expected',
                    style: AppStyle.caption.copyWith(
                      fontSize: 11,
                      color: const Color(0xFF64748B),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 2.5,
                        backgroundColor: Color(0xFF64748B),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Actual',
                        style: AppStyle.caption.copyWith(
                          fontSize: 11,
                          color: const Color(0xFF64748B),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
      
            // 3. Line Chart
            timeLabels != null
                ? PowerLineChart(timeLabels: timeLabels!)
                : const PowerLineChart(),
          ],
        ),
      ),
    );
  }
}