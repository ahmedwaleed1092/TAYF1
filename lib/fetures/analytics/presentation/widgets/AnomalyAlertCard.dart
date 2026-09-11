import 'package:flutter/material.dart';
import 'package:tayf/core/theme/app_colors.dart';
import 'package:tayf/core/theme/app_style.dart';

class AnomalyAlertCard extends StatelessWidget {
  final String title;
  final String severityText;
  final String deviation;
  final String detectedTime;
  final VoidCallback? onViewDetails;

  const AnomalyAlertCard({
    super.key,
    this.title = 'Anomaly Detected',
    this.severityText = 'High Severity',
    required this.deviation,
    required this.detectedTime,
    this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF0F0),
          borderRadius: BorderRadius.circular(13),
          border: Border.all(
            color: const Color(0xFFFFD6D6),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 1. Top Section: Alert Icon & Titles
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(
                    color: Color(0xFFB91C1C),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      '!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFB91C1C),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        severityText,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFB91C1C),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
      
            // Horizontal Divider
            const Divider(
              color: Color(0xFFFFD6D6),
              height: 1,
              thickness: 1,
            ),
            const SizedBox(height: 12),
      
            // 2. Bottom Metrics Section
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Deviation Column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Deviation',
                          style: AppStyle.caption.copyWith(
                            fontSize: 14,
                            color: const Color(0xFF5A6881),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          deviation,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFB91C1C),
                          ),
                        ),
                      ],
                    ),
                  ),
      
                  // Vertical Divider
                  const VerticalDivider(
                    color: Color(0xFFFFD6D6),
                    thickness: 1,
                    width: 1,
                  ),
      
                  // Detected At Column with Button
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Detected At',
                            style: AppStyle.caption.copyWith(
                              fontSize: 14,
                              color: const Color(0xFF5A6881),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            detectedTime,
                            style: AppStyle.body.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color:AppColors.negativeRed,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: onViewDetails,
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: AppColors.border,
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  'View Details',
                                  style: AppStyle.sectionTitle,
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
          ],
        ),
      ),
    );
  }
}