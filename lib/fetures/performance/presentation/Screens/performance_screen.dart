import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:tayf/core/theme/app_colors.dart';
import 'package:tayf/core/theme/app_style.dart';
import 'package:tayf/fetures/performance/presentation/widgets/EnergyBarChartCard.dart';
import 'package:tayf/fetures/performance/presentation/widgets/metric_card.dart';
import 'package:tayf/fetures/performance/presentation/widgets/power_chart_widget.dart';
import 'package:tayf/fetures/performance/presentation/widgets/power_metric_card.dart';
import 'package:tayf/fetures/performance/presentation/widgets/time_range_item_widget.dart';

class PerformanceScreen extends StatefulWidget {
  const PerformanceScreen({super.key});

  @override
  State<PerformanceScreen> createState() => _PerformanceScreenState();
}

class _PerformanceScreenState extends State<PerformanceScreen> {
  String selectedRange = 'Day';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryContrast,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primaryContrast,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryText),
          onPressed: () {},
        ),
        title: Text(
          'Performance Monitoring',
          style: AppStyle.title,
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Time Range Filters
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: ['Day', 'Week', 'Month', 'Year'].map((range) {
                return TimeRangeItemWidget(
                  label: range,
                  isSelected: selectedRange == range,
                  onTap: () {
                    setState(() {
                      selectedRange = range;
                    });
                  },
                );
              }).toList(),
            ),

            const Gap(20),
            Text('Power & Energy', style: AppStyle.sectionTitle),
            const Gap(12),

            // Power Metric Card
            const PowerMetricsCard(
              currentPowerValue: '69',
              expectedPowerValue: '82',
              percentage: 15.8,
            ),

            const Gap(15),

            // Power Header + Legends
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Power (KW)',
                  style: AppStyle.sectionTitle,
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.primaryText,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const Gap(6),
                        Text(
                          'Actual',
                          style: AppStyle.caption,
                        ),
                      ],
                    ),
                    const Gap(18),
                    Row(
                      children: [
                        const Text(
                          '--',
                          style: TextStyle(
                            color: AppColors.secondaryText,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            letterSpacing: -1,
                          ),
                        ),
                        Gap(6),
                        Text(
                          'Expected',
                          style: AppStyle.caption,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),

            const Gap(12),
            const PowerLineChart(),
            const Gap(12),

            // Metrics Row
            Row(
              children: const [
                MetricCard(
                  title: 'Irradiance',
                  value: '812 w/m',
                  changePercentage: '+2.3%',
                  isPositive: true,
                ),
                Gap(8),
                MetricCard(
                  title: 'Temperature',
                  value: '37 C',
                  changePercentage: '-1.2%',
                  isPositive: false,
                ),
                Gap(8),
                MetricCard(
                  title: 'Inverter Eff',
                  value: '97%',
                  changePercentage: '+0.5%',
                  isPositive: true,
                ),
              ],
            ),

            const Gap(12),
            const EnergyBarChartCard(),
            const Gap(16),
          ],
        ),
      ),
    );
  }
}