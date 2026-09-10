import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tayf/core/theme/app_colors.dart';
import 'package:tayf/core/theme/app_style.dart';

class PowerLineChart extends StatelessWidget {
  final List<String> timeLabels;

  const PowerLineChart({
    super.key,
    this.timeLabels = const ['6AM', '9AM', '12PM', '3PM', '6PM', '9PM'],
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, right: 4, bottom: 4),
      child: SizedBox(
        height: 180,
        child: LineChart(
          LineChartData(
            minX: 0,
            maxX: (timeLabels.length - 1).toDouble(),
            minY: 0,
            maxY: 5,
            gridData: const FlGridData(show: false),
            borderData: FlBorderData(
              show: true,
              border: Border.all(
                color: AppColors.border,
                width: 1,
              ),
            ),
            titlesData: FlTitlesData(
              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 28,
                  interval: 1,
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
                    if (i < 0 || i >= timeLabels.length) return const SizedBox();
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
                spots: const [
                  FlSpot(0, 0.7),
                  FlSpot(1, 1.5),
                  FlSpot(2, 2.4),
                  FlSpot(3, 3.4),
                  FlSpot(4, 2.5),
                  FlSpot(5, 4.2),
                ],
                isCurved: false,
                color: const Color(0xFF2A2A2A),
                barWidth: 2.5,
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, bar, index) => FlDotCirclePainter(
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