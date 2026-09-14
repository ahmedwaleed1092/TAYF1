import 'package:flutter/material.dart';
import 'package:tayf/core/theme/app_colors.dart';
import 'package:tayf/core/theme/app_style.dart';

class DatasetBanner extends StatelessWidget {
  final String datasetName;
  final String modelName;

  const DatasetBanner({
    super.key,
    required this.datasetName,
    required this.modelName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.soilingLightBlueBg,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.access_time_filled,
            color: AppColors.soilingTitle,
            size: 20,
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(datasetName, style: AppStyle.soilingBannerTitle),
              const SizedBox(height: 2),
              Text(modelName, style: AppStyle.soilingBannerSubtitle),
            ],
          ),
        ],
      ),
    );
  }
}
