import 'package:flutter/material.dart';
import 'package:tayf/fetures/cleaning/view/cleaning_recommendation_screen.dart';

class TableRowScreen extends StatelessWidget {
  final String label;
  final String value;
  final bool highlighted;

  const TableRowScreen({
    required this.label,
    required this.value,
    this.highlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: highlighted
            ? CleaningRecommendationScreen.greenBg
            : Colors.white,
        borderRadius: highlighted
            ? const BorderRadius.vertical(bottom: Radius.circular(14))
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,

            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: highlighted
                  ? CleaningRecommendationScreen.green
                  : CleaningRecommendationScreen.labelColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: highlighted
                  ? CleaningRecommendationScreen.green
                  : CleaningRecommendationScreen.titleColor,
            ),
          ),
        ],
      ),
    );
  }
}
