import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tayf/core/theme/app_colors.dart';
import 'package:tayf/core/theme/app_style.dart';
import 'package:tayf/fetures/smart_alarts/cubit/alerts_cubit.dart';
import 'package:tayf/fetures/smart_alarts/model/smart_alert.dart';

class PlantAlertsScreen extends StatefulWidget {
  const PlantAlertsScreen({super.key});

  @override
  State<PlantAlertsScreen> createState() => _PlantAlertsScreenState();
}

class _PlantAlertsScreenState extends State<PlantAlertsScreen> {
  int _selectedFilterIndex = 0;

  final List<String> _filters = const ['All', 'Critical', 'High', 'Medium'];

  List<AlertModel> _filterAlerts(List<AlertModel> alerts) {
    final selectedFilter = _filters[_selectedFilterIndex];

    if (selectedFilter == 'All') {
      return alerts;
    }

    return alerts.where((alert) {
      return alert.severity.trim().toLowerCase() ==
          selectedFilter.toLowerCase();
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.6,
        leading: const BackButton(color: AppColors.alertTitle),
        title: Text('Plant Alerts', style: AppStyle.chatAppBarTitle),
      ),

      body: SafeArea(
        child: BlocBuilder<AlertsCubit, AlertsState>(
          builder: (context, state) {
            // =========================
            // Loading
            // =========================
            if (state is AlertsLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            // =========================
            // Error
            // =========================
            if (state is AlertsError) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.error_outline, size: 50.sp, color: Colors.red),
                      SizedBox(height: 12.h),
                      Text(
                        'Failed to load alerts',
                        style: AppStyle.sectionTitle,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        state.error,
                        style: AppStyle.chatBotMessage,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20.h),
                      ElevatedButton(
                        onPressed: () {
                          context.read<AlertsCubit>().getAlerts();
                        },
                        child: const Text('Try Again'),
                      ),
                    ],
                  ),
                ),
              );
            }

            // =========================
            // Initial
            // =========================
            if (state is AlertsInitial) {
              return const Center(child: CircularProgressIndicator());
            }

            // =========================
            // Success
            // =========================
            if (state is AlertsSuccess) {
              final alerts = _filterAlerts(state.alerts);

              return Column(
                children: [
                  // =========================
                  // Filters
                  // =========================
                  Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 4.h),
                    child: _AlertFilterTabs(
                      filters: _filters,
                      selectedIndex: _selectedFilterIndex,
                      onSelected: (index) {
                        setState(() {
                          _selectedFilterIndex = index;
                        });
                      },
                    ),
                  ),

                  // =========================
                  // Alerts List
                  // =========================
                  Expanded(
                    child: alerts.isEmpty
                        ? Center(
                            child: Text(
                              'No alerts in this category',
                              style: AppStyle.chatAppBarTitle,
                            ),
                          )
                        : RefreshIndicator(
                            onRefresh: () {
                              return context.read<AlertsCubit>().getAlerts();
                            },
                            child: ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              padding: EdgeInsets.fromLTRB(
                                16.w,
                                12.h,
                                16.w,
                                16.h,
                              ),
                              itemCount: alerts.length,
                              itemBuilder: (context, index) {
                                final alert = alerts[index];

                                return Padding(
                                  padding: EdgeInsets.only(bottom: 14.h),
                                  child: AlertCard(alert: alert),
                                );
                              },
                            ),
                          ),
                  ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

// ============================================================
// Filter Tabs
// ============================================================

class _AlertFilterTabs extends StatelessWidget {
  final List<String> filters;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const _AlertFilterTabs({
    required this.filters,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;

          return GestureDetector(
            onTap: () => onSelected(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.alertTitle : Colors.white,
                borderRadius: BorderRadius.circular(22.r),
                border: Border.all(
                  color: isSelected
                      ? AppColors.alertTitle
                      : Colors.grey.shade300,
                ),
              ),
              child: Text(
                filters[index],
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : Colors.grey.shade700,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ============================================================
// Severity Style
// ============================================================

class SeverityStyle {
  final Color background;
  final Color border;
  final Color badgeBg;
  final Color badgeText;
  final Color iconColor;
  final IconData icon;
  final String label;

  const SeverityStyle({
    required this.background,
    required this.border,
    required this.badgeBg,
    required this.badgeText,
    required this.iconColor,
    required this.icon,
    required this.label,
  });

  static SeverityStyle of(String severity) {
    switch (severity.trim().toLowerCase()) {
      case 'critical':
        return const SeverityStyle(
          background: AppColors.alertHighBackground,
          border: AppColors.alertHighBorder,
          badgeBg: AppColors.alertHighBadgeBg,
          badgeText: AppColors.alertHighBadgeText,
          iconColor: AppColors.alertHighIcon,
          icon: Icons.error,
          label: 'Critical',
        );

      case 'high':
        return const SeverityStyle(
          background: AppColors.alertHighBackground,
          border: AppColors.alertHighBorder,
          badgeBg: AppColors.alertHighBadgeBg,
          badgeText: AppColors.alertHighBadgeText,
          iconColor: AppColors.alertHighIcon,
          icon: Icons.error,
          label: 'High',
        );

      case 'medium':
        return const SeverityStyle(
          background: AppColors.alertMediumBackground,
          border: AppColors.alertMediumBorder,
          badgeBg: AppColors.alertMediumBadgeBg,
          badgeText: AppColors.alertMediumBadgeText,
          iconColor: AppColors.alertMediumIcon,
          icon: Icons.error_outline,
          label: 'Medium',
        );

      default:
        return const SeverityStyle(
          background: AppColors.alertInfoBackground,
          border: AppColors.alertInfoBorder,
          badgeBg: AppColors.alertInfoBadgeBg,
          badgeText: AppColors.alertInfoBadgeText,
          iconColor: AppColors.alertInfoIcon,
          icon: Icons.info_outline,
          label: 'Info',
        );
    }
  }
}

// ============================================================
// Alert Card
// ============================================================

class AlertCard extends StatelessWidget {
  final AlertModel alert;

  const AlertCard({super.key, required this.alert});

  @override
  Widget build(BuildContext context) {
    final style = SeverityStyle.of(alert.severity);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: style.background,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: style.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ====================================================
          // Header
          // ====================================================

          Row(
            children: [
              Icon(style.icon, color: style.iconColor, size: 20.sp),

              SizedBox(width: 8.w),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: style.badgeBg,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  style.label,
                  style: AppStyle.chatActionTitle.copyWith(
                    color: style.badgeText,
                  ),
                ),
              ),

              const Spacer(),

              if (alert.asset.isNotEmpty && alert.asset != '-')
                Flexible(
                  child: Text(
                    alert.asset,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                    style: AppStyle.chatActionTitle,
                  ),
                ),
            ],
          ),

          SizedBox(height: 10.h),

          // ====================================================
          // Problem
          // ====================================================
          Text(alert.problem, style: AppStyle.sectionTitle),

          SizedBox(height: 8.h),

          // ====================================================
          // Energy Loss
          // ====================================================
          _InfoLine(
            label: 'Estimated Energy Loss',
            value: '${alert.energyLossKwh.toStringAsFixed(1)} KWh',
          ),

          SizedBox(height: 6.h),

          // ====================================================
          // Financial Loss
          // ====================================================
          _InfoLine(
            label: 'Estimated Financial Loss',
            value: '${alert.financialLossEgp.toStringAsFixed(1)} EGP',
          ),

          SizedBox(height: 6.h),

          // ====================================================
          // Root Cause
          // ====================================================
          _InfoLine(label: 'Probable Cause', value: alert.rootCause),

          SizedBox(height: 6.h),

          // ====================================================
          // Recommended Action
          // ====================================================
          _InfoLine(label: 'Action', value: alert.recommendedAction),
        ],
      ),
    );
  }
}

// ============================================================
// Info Line
// ============================================================

class _InfoLine extends StatelessWidget {
  final String label;
  final String value;

  const _InfoLine({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: '$label - ', style: AppStyle.soilingStatLabel),
          TextSpan(text: value, style: AppStyle.chatBotMessage),
        ],
      ),
    );
  }
}
