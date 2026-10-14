import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tayf/core/routing/routs.dart';
import 'package:tayf/fetures/analytics/view/components/next_navigation_button.dart';
import 'package:tayf/fetures/analytics/view/components/performance_status_card.dart';
import 'package:tayf/fetures/analytics/view/components/power_comparison_card.dart';
import 'package:tayf/fetures/analytics/view/components/power_comparison_summary_card.dart';
import 'package:tayf/fetures/home/cubit/dashboard_data_cubit.dart'; // TelemetryCubit + state (عدّل المسار)
import 'package:tayf/fetures/home/cubit/dashboard_data_state.dart';
import 'package:tayf/fetures/home/model/telemetry_model.dart';
import 'package:tayf/fetures/performance/presentation/cubit/sensor_cubit.dart';
import 'package:tayf/fetures/performance/presentation/cubit/sensor_state.dart';
import 'package:tayf/fetures/performance/presentation/widgets/time_range_item_widget.dart';

// import موديل TelemetryModel لو كان في ملف لوحده

const double kPlantRatedKw = 100; // غيّره للقدرة الاسمية الحقيقية

class ExpectedVsActualBody extends StatefulWidget {
  const ExpectedVsActualBody({super.key});

  @override
  State<ExpectedVsActualBody> createState() => _ExpectedVsActualBodyState();
}

class _ExpectedVsActualBodyState extends State<ExpectedVsActualBody> {
  String selectedRange = 'Today';

  // الافتراض الوحيد عن الـ TelemetryCubit: عدّل السطر ده لو مختلف
  TelemetryModel? _latestActual(TelemetryState state) {
    if (state is! TelemetryLoaded) return null;
    final items = state.telemetry.items;
    if (items.isEmpty) return null;
    return items.reduce((a, b) => a.timestamp.isAfter(b.timestamp) ? a : b);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: ['Today', '7 Days', '30 Days'].map((range) {
              return TimeRangeItemWidget(
                label: range,
                isSelected: selectedRange == range,
                onTap: () => setState(() => selectedRange = range),
              );
            }).toList(),
          ),
          const Gap(20),
          Builder(
            builder: (context) {
              final sensor = context.watch<SensorCubit>().state;
              final telemetry = context.watch<TelemetryCubit>().state;

              final expectedKw = sensor.latest == null
                  ? null
                  : sensor.latest!.expectedPowerNorm * kPlantRatedKw;
              final actualKw = _latestActual(telemetry)?.acPowerKw;

              final hasBoth =
                  expectedKw != null && actualKw != null && expectedKw > 0;
              final deviation = hasBoth
                  ? (actualKw - expectedKw) / expectedKw * 100
                  : null;

              return Column(
                children: [
                  PowerComparisonSummaryCard(
                    expectedPower: expectedKw == null
                        ? '--'
                        : expectedKw.toStringAsFixed(1),
                    actualPower: actualKw == null
                        ? '--'
                        : actualKw.toStringAsFixed(1),
                    deviation: deviation == null
                        ? '--'
                        : '${deviation.toStringAsFixed(1)}%',
                  ),
                  const Gap(20),
                  const PowerComparisonCard(),
                  const Gap(20),
                  _statusCard(sensor, deviation),
                ],
              );
            },
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0, bottom: 16.0),
              child: NextNavigationButton(
                onTap: () {
                  GoRouter.of(context).pushNamed(Routs.rootAnalysisScreen);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusCard(SensorState sensor, double? deviation) {
    final r = sensor.latest;

    if (r == null) {
      return const PerformanceStatusCard(
        statusTitle: 'Connecting...',
        deviationText: 'Waiting for sensor data',
        level: PerformanceLevel.waiting,
      );
    }
    if (!r.daytime) {
      return const PerformanceStatusCard(
        statusTitle: 'Night / Idle',
        deviationText: 'No production expected',
        level: PerformanceLevel.idle,
      );
    }
    if (deviation == null) {
      return const PerformanceStatusCard(
        statusTitle: 'Waiting for actual data',
        deviationText: 'Deviation unavailable',
        level: PerformanceLevel.waiting,
      );
    }

    final isLow = deviation < -10;
    return PerformanceStatusCard(
      statusTitle: isLow ? 'Underperforming' : 'Normal',
      deviationText: '${deviation.toStringAsFixed(1)}% deviation',
      level: isLow ? PerformanceLevel.warning : PerformanceLevel.normal,
    );
  }
}
