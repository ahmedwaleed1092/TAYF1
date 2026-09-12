import 'package:flutter/material.dart';

class EnergyComparisonCard extends StatelessWidget {
  final String expectedValue;
  final String expectedUnit;
  final String actualValue;
  final String actualUnit;

  const EnergyComparisonCard({
    super.key,
    required this.expectedValue,
    required this.expectedUnit,
    required this.actualValue,
    required this.actualUnit,
  });

  static const Color titleColor = Color(0xFF16326B); // أزرق داكن
  static const Color labelColor = Color(0xFF6B7280); // رمادي

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE3E6EC), width: 1.2),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Energy Comparison',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: titleColor,
            ),
          ),
          const SizedBox(height: 16),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: _EnergyColumn(
                    label: 'Expected Energy',
                    value: expectedValue,
                    unit: expectedUnit,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: VerticalDivider(
                    color: Color(0xFFE3E6EC),
                    thickness: 1,
                    width: 1,
                  ),
                ),
                Expanded(
                  child: _EnergyColumn(
                    label: 'Actual Energy',
                    value: actualValue,
                    unit: actualUnit,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EnergyColumn extends StatelessWidget {
  final String label;
  final String value;
  final String unit;

  const _EnergyColumn({
    required this.label,
    required this.value,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: EnergyComparisonCard.labelColor,
          ),
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: EnergyComparisonCard.titleColor,
                ),
              ),
              TextSpan(
                text: ' $unit',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: EnergyComparisonCard.titleColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
