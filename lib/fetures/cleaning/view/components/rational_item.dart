import 'package:flutter/material.dart';
import 'package:tayf/fetures/cleaning/view/cleaning_recommendation_screen.dart';

class RationaleItem extends StatelessWidget {
  final String text;

  const RationaleItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check,
            color: CleaningRecommendationScreen.green,
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: CleaningRecommendationScreen.titleColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
