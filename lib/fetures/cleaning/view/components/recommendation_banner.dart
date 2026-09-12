import 'package:flutter/material.dart';
import 'package:tayf/fetures/cleaning/view/cleaning_recommendation_screen.dart';

class RecommendationBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: CleaningRecommendationScreen.greenBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFBFE8CC)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: CleaningRecommendationScreen.green,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.bolt, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 10),
              const Text(
                'Recommendation',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,

                  color: CleaningRecommendationScreen.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Text(
            'CLEAN NOW',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w900,
              color: CleaningRecommendationScreen.green,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Net benefit exceeds cleaning',
            style: TextStyle(
              fontSize: 14,
              color: CleaningRecommendationScreen.labelColor,
            ),
          ),
        ],
      ),
    );
  }
}
