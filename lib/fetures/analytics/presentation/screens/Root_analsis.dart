import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:tayf/core/theme/app_colors.dart';
import 'package:tayf/core/theme/app_style.dart';
import 'package:tayf/fetures/analytics/presentation/widgets/DetectedEventItem.dart';
import 'package:tayf/fetures/analytics/presentation/widgets/NextNavigationButton.dart';
import 'package:tayf/fetures/analytics/presentation/widgets/anomaly_score_card.dart';
import 'package:tayf/fetures/analytics/presentation/widgets/soiling_confidence_card.dart';

class RootAnalsis extends StatelessWidget {
  const RootAnalsis({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primaryContrast,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryText),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Root Cause Analysis', style: AppStyle.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SoilingConfidenceCard(percentage: 70, confidence: 86),
            const Gap(24),

            // Detected Events Section Title
            const Text(
              'Problem Causes',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F2B48),
              ),
            ),
            const Gap(12),

            // Events List
            const DetectedEventItem(
              title: 'Abnormal Power Drop',
              subtitle: '-15.8%',
              severity: EventSeverity.high,
            ),
            const Gap(12),

            const DetectedEventItem(
              title: 'Performance Deviation',
              subtitle: '-15.8%',
              severity: EventSeverity.high,
            ),
            const Gap(12),

            const DetectedEventItem(
              title: 'Electrical Behavior',
              subtitle: 'Normal',
              severity: EventSeverity.low,
            ),

            Gap(12),
            const AnomalyScoreCard(score: 92, total: 100),
            const Gap(12),
            Align(
              alignment: Alignment.centerRight,
              child: NextNavigationButton(onTap: () {}),
            ),
          ],
        ),
      ),
    );
  }
}
