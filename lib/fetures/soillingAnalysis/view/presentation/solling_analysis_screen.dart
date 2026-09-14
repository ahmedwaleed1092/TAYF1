import 'package:flutter/material.dart';
import 'package:tayf/core/theme/app_colors.dart';
import 'package:tayf/core/theme/app_style.dart';
import 'package:tayf/fetures/soillingAnalysis/view/components/dataset_banner.dart';
import 'package:tayf/fetures/soillingAnalysis/view/components/impact_estimation_card.dart';
import 'package:tayf/fetures/soillingAnalysis/view/components/model_inputs_grid.dart';
import 'package:tayf/fetures/soillingAnalysis/view/components/next_button.dart';
import 'package:tayf/fetures/soillingAnalysis/view/components/soiling_bottom_nav_bar.dart';
import 'package:tayf/fetures/soillingAnalysis/view/components/soiling_trend_card.dart';
import 'package:tayf/fetures/soillingAnalysis/view/components/stats_row.dart';

class SoilingAnalysisScreen extends StatelessWidget {
  final String datasetName;
  final String modelName;
  final String estimatedSoiling;
  final String performanceImpact;
  final List<String> modelInputs;
  final String energyLoss;
  final String financialLoss;
  final List<double> trendValues; // 0.0 - 1.0 (percent as fraction)
  final List<String> trendLabels;
  final VoidCallback? onNext;

  const SoilingAnalysisScreen({
    super.key,
    this.datasetName = 'Andasol-3 Dataset',
    this.modelName = 'Soiling Model',
    this.estimatedSoiling = '4%',
    this.performanceImpact = '8.2%',
    this.modelInputs = const [
      'POA / GHI Irradiance',
      'Module Temperature',
      'Ambient Temperature',
      'Rainfall',
      'Wind Speed',
      'Relative Humidity',
      'PDC Normalized by Irradiance',
      'Performance Ratio / Relative Residual',
      'String Mismatch',
      'Dry Days',
      'Rainfall — 7 Day Accumulation',
      'Dew Point',
      'Solar Geometry',
      '24h Performance Rolling Mean',
      'Performance Trend',
      'Days Since Rain',
      'Days Since Cleaning',
      'SLR Lags',
      'Cleaning Recovery',
    ],
    this.energyLoss = '1,240 KWh',
    this.financialLoss = '16,120 EGP',
    this.trendValues = const [
      0.01,
      0.03,
      0.05,
      0.07,
      0.06,
      0.09,
      0.10,
      0.09,
      0.11,
      0.13,
      0.12,
      0.15,
      0.19,
    ],
    this.trendLabels = const ['Apr 7', '9', '11', '13'],
    this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.6,
        leading: const BackButton(color: AppColors.soilingTitle),
        title: Text('Soiling Analysis', style: AppStyle.soilingAppBarTitle),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DatasetBanner(
                      datasetName: datasetName,
                      modelName: modelName,
                    ),
                    const SizedBox(height: 16),
                    StatsRow(
                      estimatedSoiling: estimatedSoiling,
                      performanceImpact: performanceImpact,
                    ),
                    const SizedBox(height: 22),
                    Text('Model Inputs', style: AppStyle.soilingSectionTitle),
                    const SizedBox(height: 14),
                    ModelInputsGrid(inputs: modelInputs),
                    const SizedBox(height: 22),
                    ImpactEstimationCard(
                      energyLoss: energyLoss,
                      financialLoss: financialLoss,
                    ),
                    const SizedBox(height: 22),
                    SoilingTrendCard(values: trendValues, xLabels: trendLabels),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerRight,
                      child: NextButton(onTap: () {}),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
