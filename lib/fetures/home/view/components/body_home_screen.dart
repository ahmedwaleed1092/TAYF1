import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tayf/fetures/home/cubit/dashboard_data_cubit.dart';
import 'package:tayf/fetures/home/cubit/dashboard_data_state.dart';

import 'package:tayf/fetures/home/view/components/active_alert_card.dart';
import 'package:tayf/fetures/home/view/components/headline_title.dart';
import 'package:tayf/fetures/home/view/components/pannal_data_image.dart';
import 'package:tayf/fetures/home/view/components/peformance_card.dart';
import 'package:tayf/fetures/home/view/components/peformance_data.dart';

class BodyHomeScreen extends StatelessWidget {
  const BodyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: BlocBuilder<TelemetryCubit, TelemetryState>(
          builder: (context, state) {
            // =====================================================
            // Loading
            // =====================================================

            if (state is TelemetryLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            // =====================================================
            // Error
            // =====================================================

            if (state is TelemetryError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 50,
                      color: Colors.redAccent,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      state.error,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.redAccent,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<TelemetryCubit>().fetchTelemetry();
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            // =====================================================
            // Loaded
            // =====================================================

            if (state is TelemetryLoaded) {
              final items = state.telemetry.items ?? [];

              if (items.isEmpty) {
                return const Center(
                  child: Text(
                    'No telemetry data available.',
                    style: TextStyle(color: Color(0xFF242F41), fontSize: 16),
                  ),
                );
              }

              // API returns the newest reading first.
              final latest = items.first;

              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15.h),

                    // =================================================
                    // Header
                    // =================================================
                    headlineTitle(),

                    Divider(
                      color: const Color(0xff242F41),
                      thickness: 1,
                      indent: 10.h,
                      endIndent: 10.h,
                    ),

                    // =================================================
                    // Panel Image
                    // =================================================
                    BannalData(),

                    SizedBox(height: 16.h),

                    // =================================================
                    // Performance Data
                    // =================================================
                    PeformanceData(),

                    SizedBox(height: 26.h),

                    // =================================================
                    // Telemetry Cards
                    // =================================================
                    SizedBox(
                      width: double.infinity,
                      height: 250.h,
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 1,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          switch (index) {
                            case 0:
                              return PerformanceRatioCard(
                                title: 'AC Power',
                                value:
                                    '${latest.acPowerKw?.toStringAsFixed(2) ?? '0'} kW',
                                width: 120.w,
                                height: 80.h,
                                peformanceNote: 'Current Output',
                              );

                            case 1:
                              return PerformanceRatioCard(
                                title: 'DC Power',
                                value:
                                    '${latest.dcPowerKw?.toStringAsFixed(2) ?? '0'} kW',
                                width: 120.w,
                                height: 80.h,
                                peformanceNote: 'DC Output',
                              );

                            case 2:
                              return PerformanceRatioCard(
                                title: 'Irradiance',
                                value:
                                    '${latest.irradiance?.toStringAsFixed(0) ?? '0'} W/m²',
                                width: 120.w,
                                height: 80.h,
                                peformanceNote: 'Solar Radiation',
                              );

                            case 3:
                              return PerformanceRatioCard(
                                title: 'Ambient Temp.',
                                value:
                                    '${latest.ambientTemperature?.toStringAsFixed(1) ?? '0'} °C',
                                width: 120.w,
                                height: 80.h,
                                peformanceNote: 'Ambient',
                              );

                            case 4:
                              return PerformanceRatioCard(
                                title: 'Module Temp.',
                                value:
                                    '${latest.moduleTemperature?.toStringAsFixed(1) ?? '0'} °C',
                                width: 120.w,
                                height: 80.h,
                                peformanceNote: 'Module',
                              );

                            case 5:
                              return PerformanceRatioCard(
                                title: 'Daily Yield',
                                value:
                                    '${latest.dailyYield?.toStringAsFixed(0) ?? '0'} kWh',
                                width: 120.w,
                                height: 80.h,
                                peformanceNote: 'Today',
                              );

                            default:
                              return const SizedBox.shrink();
                          }
                        },
                      ),
                    ),

                    SizedBox(height: 20.h),

                    // =================================================
                    // Active Alerts
                    // =================================================
                    ActiveAlertsCard(alerts: _buildAlerts(latest)),

                    SizedBox(height: 20.h),

                    // =================================================
                    // Total Yield Information
                    // =================================================
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFF191D24),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total Yield',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '${latest.totalYield?.toStringAsFixed(0) ?? '0'} kWh',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20.h),
                  ],
                ),
              );
            }

            // =====================================================
            // Initial
            // =====================================================

            return const Center(
              child: Text(
                'Waiting for telemetry data...',
                style: TextStyle(color: Color(0xFF242F41)),
              ),
            );
          },
        ),
      ),
    );
  }

  // =============================================================
  // Build Alerts
  // =============================================================

  static List<AlertItem> _buildAlerts(dynamic telemetry) {
    final List<AlertItem> alerts = [];

    final acPower = telemetry.acPowerKw ?? 0;
    final dcPower = telemetry.dcPowerKw ?? 0;
    final irradiance = telemetry.irradiance ?? 0;
    final moduleTemperature = telemetry.moduleTemperature ?? 0;

    // AC Power
    alerts.add(
      AlertItem(
        title: 'Current AC Power',
        details: '${acPower.toStringAsFixed(2)} kW',
      ),
    );

    // DC Power
    alerts.add(
      AlertItem(
        title: 'Current DC Power',
        details: '${dcPower.toStringAsFixed(2)} kW',
      ),
    );

    // Irradiance
    alerts.add(
      AlertItem(
        title: 'Irradiance',
        details: '${irradiance.toStringAsFixed(0)} W/m²',
      ),
    );

    // Temperature warning
    if (moduleTemperature >= 50) {
      alerts.add(
        AlertItem(
          title: 'High Module Temperature',
          details: '${moduleTemperature.toStringAsFixed(1)} °C',
        ),
      );
    }

    return alerts;
  }
}
