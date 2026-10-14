import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tayf/core/theme/app_colors.dart';
import 'package:tayf/core/theme/app_style.dart';
import 'package:tayf/fetures/performance/presentation/cubit/sensor_cubit.dart';
import 'package:tayf/fetures/performance/presentation/cubit/sensor_state.dart';
import 'package:tayf/fetures/performance/presentation/widgets/power_chart_widget.dart';

class PowerComparisonCard extends StatelessWidget {
  const PowerComparisonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Power Comparison',
              style: AppStyle.sectionTitle.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: const Color(0xFF0F2B48),
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '-- Expected',
                    style: AppStyle.caption.copyWith(
                      fontSize: 11,
                      color: const Color(0xFF64748B),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 2.5,
                        backgroundColor: Color(0xFF64748B),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Actual',
                        style: AppStyle.caption.copyWith(
                          fontSize: 11,
                          color: const Color(0xFF64748B),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            BlocBuilder<SensorCubit, SensorState>(
              buildWhen: (p, c) => p.latest?.seq != c.latest?.seq,
              builder: (context, state) {
                final h = state.history;
                if (h.isEmpty) {
                  return const SizedBox(
                    height: 200,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                final fmt = DateFormat('HH:mm');
                final values = h.map((e) => e.expectedPowerNorm * 100).toList();
                final labels = h.map((e) => fmt.format(e.timestamp)).toList();
                return PowerLineChart(values: values, timeLabels: labels);
              },
            ),
          ],
        ),
      ),
    );
  }
}
