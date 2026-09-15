import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:tayf/fetures/analytics/view/components/anomaly_alert_card.dart';
import 'package:tayf/fetures/analytics/view/components/anomaly_score_card.dart';
import 'package:tayf/fetures/analytics/view/components/detected_event_item.dart';

class AnomalyDetectionBody extends StatelessWidget {
  const AnomalyDetectionBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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

          const Gap(12),
          const AnomalyScoreCard(score: 92, total: 100),
        ],
      ),
    );
  }
}
