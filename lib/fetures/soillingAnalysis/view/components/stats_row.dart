import 'package:flutter/material.dart';
import 'package:tayf/core/theme/app_colors.dart';
import 'package:tayf/core/theme/app_style.dart';

class StatsRow extends StatelessWidget {
  final String estimatedSoiling;
  final String performanceImpact;

  const StatsRow({
    super.key,
    required this.estimatedSoiling,
    required this.performanceImpact,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.soilingCardBorder),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: _StatCell(
                label: 'Estimated Soiling',
                value: estimatedSoiling,
              ),
            ),
            const VerticalDivider(
              width: 1,
              color: AppColors.soilingCardBorder,
            ),
            Expanded(
              child: _StatCell(
                label: 'Performance Impact',
                value: performanceImpact,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCell extends StatelessWidget {
  final String label;
  final String value;

  const _StatCell({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppStyle.soilingStatLabel),
          const SizedBox(height: 6),
          Text(value, style: AppStyle.soilingStatValue),
        ],
      ),
    );
  }
}
