import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:tayf/core/theme/app_colors.dart';
import 'package:tayf/core/theme/app_style.dart';
import 'package:tayf/fetures/analytics/presentation/widgets/AnomalyAlertCard.dart';
import 'package:tayf/fetures/analytics/presentation/widgets/DetectedEventItem.dart';
import 'package:tayf/fetures/analytics/presentation/widgets/anomaly_score_card.dart';

class AnomalyDetectionScreen extends StatelessWidget {
  const AnomalyDetectionScreen({super.key});

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
        title: Text('Anomaly Detection', style: AppStyle.title),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Alert Card
            AnomalyAlertCard(
              deviation: '-15.8%',
              detectedTime: '10 : 24  AM',
              onViewDetails: () {
                // Action on details tap
              },
            ),

            const Gap(24),

            // Detected Events Section Title
            const Text(
              'Detected Events',
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
   const AnomalyScoreCard(
  score: 92,
  total: 100,
)

          ],
        ),
      ),
    );
  }
}