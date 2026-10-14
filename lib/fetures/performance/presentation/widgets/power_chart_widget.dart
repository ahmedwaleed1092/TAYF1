import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tayf/core/theme/app_colors.dart';
import 'package:tayf/core/theme/app_style.dart';

class PowerLineChart extends StatelessWidget {
  final List<String> timeLabels;
  final List<double>? values;

  const PowerLineChart({
    super.key,
    this.timeLabels = const ['6AM', '9AM', '12PM', '3PM', '6PM', '9PM'],
    this.values,
  });

  static const List<double> _defaultValues = [0.7, 1.5, 2.4, 3.4, 2.5, 4.2];

  @override
  Widget build(BuildContext context) {
    final data = values ?? _defaultValues;
    final isLive = values != null;

    final spots = [
      for (int i = 0; i < data.length; i++) FlSpot(i.toDouble(), data[i]),
    ];

    final maxX = math.max(data.length - 1, 1).toDouble();

    double maxY = 5;
    double yInterval = 1;
    if (isLive && data.isNotEmpty) {
      final peak = data.reduce(math.max);
      maxY = math.max(10, (peak * 1.2 / 10).ceilToDouble() * 10);
      yInterval = maxY / 5;
    }

    final xLabelStep = math.max(1, (data.length / 5).ceil());

    return Padding(
      padding: const EdgeInsets.only(top: 8, right: 4, bottom: 4),
      child: SizedBox(
        height: 180,
        child: LineChart(
          duration: Duration.zero,
          LineChartData(
            minX: 0,
            maxX: maxX,
            minY: 0,
            maxY: maxY,
            gridData: const FlGridData(show: false),
            borderData: FlBorderData(
              show: true,
              border: Border.all(color: AppColors.border, width: 1),
            ),
            titlesData: FlTitlesData(
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 32,
                  interval: yInterval,
                  getTitlesWidget: (value, meta) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: Text(
                        value.toInt().toString(),
                        textAlign: TextAlign.right,
                        style: AppStyle.caption.copyWith(
                          color: Colors.grey,
                          fontSize: 11,
                        ),
                      ),
                    );
                  },
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 26,
                  interval: 1,
                  getTitlesWidget: (value, meta) {
                    final i = value.toInt();
                    if (value != i.toDouble()) return const SizedBox();
                    if (i < 0 || i >= timeLabels.length) {
                      return const SizedBox();
                    }
                    if (isLive && i % xLabelStep != 0) {
                      return const SizedBox();
                    }
                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        timeLabels[i],
                        style: AppStyle.caption.copyWith(
                          color: Colors.grey,
                          fontSize: 10,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            lineBarsData: [
              LineChartBarData(
                spots: spots,
                isCurved: false,
                color: const Color(0xFF2A2A2A),
                barWidth: 2.5,
                dotData: FlDotData(
                  show: !isLive || data.length <= 12,
                  getDotPainter: (spot, percent, bar, index) =>
                      FlDotCirclePainter(
                        radius: 3.5,
                        color: Colors.white,
                        strokeWidth: 2,
                        strokeColor: const Color(0xFF2A2A2A),
                      ),
                ),
                belowBarData: BarAreaData(
                  show: true,
                  color: const Color(0xFF1D35C2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
