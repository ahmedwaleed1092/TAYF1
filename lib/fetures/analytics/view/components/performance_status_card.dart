import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:tayf/core/theme/app_colors.dart';
import 'package:tayf/core/theme/app_style.dart';

enum PerformanceLevel { normal, warning, idle, waiting }

class PerformanceStatusCard extends StatelessWidget {
  final String statusTitle;
  final String deviationText;
  final PerformanceLevel level;

  const PerformanceStatusCard({
    super.key,
    this.statusTitle = 'Underperforming',
    this.deviationText = '-15.8% deviation',
    this.level = PerformanceLevel.warning,
  });

  Color get _bg => switch (level) {
    PerformanceLevel.warning => const Color(0xFFFFF0F0),
    PerformanceLevel.normal => const Color(0xFFEFFAF3),
    _ => const Color(0xFFF5F7FA),
  };

  Color get _border => switch (level) {
    PerformanceLevel.warning => const Color(0xFFFFD6D6),
    PerformanceLevel.normal => const Color(0xFFC9EFD6),
    _ => const Color(0xFFE2E8F0),
  };

  Color get _titleColor => switch (level) {
    PerformanceLevel.warning => const Color(0xFFEA580C),
    PerformanceLevel.normal => const Color(0xFF16A34A),
    _ => const Color(0xFF475569),
  };

  Color get _iconColor => switch (level) {
    PerformanceLevel.warning => AppColors.negativeRed,
    PerformanceLevel.normal => const Color(0xFF16A34A),
    _ => const Color(0xFF64748B),
  };

  IconData get _icon => switch (level) {
    PerformanceLevel.warning => Icons.warning_amber_rounded,
    PerformanceLevel.normal => Icons.check_circle_outline_rounded,
    PerformanceLevel.idle => Icons.nightlight_round,
    PerformanceLevel.waiting => Icons.hourglass_empty_rounded,
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _bg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _border, width: 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(_icon, color: _iconColor, size: 24),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'status',
                    style: AppStyle.caption.copyWith(fontSize: 16),
                  ),
                  const Gap(8),
                  Text(
                    statusTitle,
                    style: TextStyle(
                      color: _titleColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(4),
                  Text(
                    deviationText,
                    style: AppStyle.precentageChange.copyWith(
                      fontSize: 16,
                      color: _titleColor,
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
