import 'package:flutter/material.dart';
import 'package:tayf/core/theme/app_colors.dart';
import 'package:tayf/core/theme/app_style.dart';

class ImpactEstimationCard extends StatelessWidget {
  final String energyLoss;
  final String financialLoss;

  const ImpactEstimationCard({
    super.key,
    required this.energyLoss,
    required this.financialLoss,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.soilingCardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Impact Estimation', style: AppStyle.soilingCardTitle),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _ImpactCell(label: 'Energy Loss', value: energyLoss),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _ImpactCell(
                  label: 'Financial Loss',
                  value: financialLoss,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ImpactCell extends StatelessWidget {
  final String label;
  final String value;

  const _ImpactCell({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.soilingLightBlueBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppStyle.soilingImpactLabel),
          const SizedBox(height: 6),
          Text(value, style: AppStyle.soilingImpactValue),
        ],
      ),
    );
  }
}
