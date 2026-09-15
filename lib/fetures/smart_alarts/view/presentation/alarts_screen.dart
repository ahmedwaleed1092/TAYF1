import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tayf/core/theme/app_style.dart';
import 'package:tayf/fetures/smart_alarts/cubit/alerts_cubit.dart';
import 'package:tayf/fetures/smart_alarts/model/smart_alert.dart';

class PlantAlertsScreen extends StatefulWidget {
  const PlantAlertsScreen({super.key});

  @override
  State<PlantAlertsScreen> createState() => _PlantAlertsScreenState();
}

class _PlantAlertsScreenState extends State<PlantAlertsScreen> {
  String selectedSeverity = 'All';

  @override
  void initState() {
    super.initState();

    // Load alerts when screen opens
    context.read<AlertsCubit>().getAlerts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: Text(
          'Plant Alerts',
          style: AppStyle.graySimiBold16.copyWith(
            color: const Color(0xFF123B70),
            fontSize: 20.sp,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF123B70)),
      ),
      body: BlocBuilder<AlertsCubit, AlertsState>(
        builder: (context, state) {
          // ---------------------------
          // Loading
          // ---------------------------
          if (state is AlertsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // ---------------------------
          // Error
          // ---------------------------
          if (state is AlertsError) {
            return _ErrorView(
              message: state.error,
              onRetry: () {
                context.read<AlertsCubit>().getAlerts();
              },
            );
          }

          // ---------------------------
          // Initial
          // ---------------------------
          if (state is AlertsInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          // ---------------------------
          // Success
          // ---------------------------
          if (state is AlertsSuccess) {
            final allAlerts = state.alerts;

            final filteredAlerts = selectedSeverity == 'All'
                ? allAlerts
                : allAlerts.where((alert) {
                    return alert.severity.toLowerCase() ==
                        selectedSeverity.toLowerCase();
                  }).toList();

            return Column(
              children: [
                SizedBox(height: 12.h),

                // Severity filters
                _AlertFilterTabs(
                  selectedSeverity: selectedSeverity,
                  onChanged: (value) {
                    setState(() {
                      selectedSeverity = value;
                    });
                  },
                ),

                SizedBox(height: 12.h),

                // Alerts list
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await context.read<AlertsCubit>().getAlerts();
                    },
                    child: filteredAlerts.isEmpty
                        ? ListView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            children: [
                              SizedBox(height: 150.h),
                              const Center(
                                child: Text(
                                  'No alerts found',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : ListView.builder(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 8.h,
                            ),
                            itemCount: filteredAlerts.length,
                            itemBuilder: (context, index) {
                              final alert = filteredAlerts[index];

                              return Padding(
                                padding: EdgeInsets.only(bottom: 12.h),
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
    );
  }
}

// ============================================================
// FILTER TABS
// ============================================================

class _AlertFilterTabs extends StatelessWidget {
  final String selectedSeverity;
  final ValueChanged<String> onChanged;

  const _AlertFilterTabs({
    required this.selectedSeverity,
    required this.onChanged,
  });

  static const List<String> filters = ['All', 'Critical', 'High', 'Medium'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42.h,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = selectedSeverity == filter;

          return GestureDetector(
            onTap: () => onChanged(filter),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 9.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF123B70)
                    : const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                filter,
                style: TextStyle(
                  color: isSelected ? Colors.white : const Color(0xFF6B7280),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
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
// ALERT CARD
// ============================================================

class AlertCard extends StatelessWidget {
  final AlertModel alert;

  const AlertCard({super.key, required this.alert});

  @override
  Widget build(BuildContext context) {
    final severityStyle = SeverityStyle.of(alert.severity);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: severityStyle.borderColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --------------------------------------------------
          // Header
          // --------------------------------------------------
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 42.w,
                height: 42.w,
                decoration: BoxDecoration(
                  color: severityStyle.backgroundColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  severityStyle.icon,
                  color: severityStyle.iconColor,
                  size: 22.sp,
                ),
              ),

              SizedBox(width: 12.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      alert.problem,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyle.graySimiBold16.copyWith(
                        color: const Color(0xFF123B70),
                        fontSize: 15.sp,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      alert.asset,
                      style: TextStyle(
                        color: const Color(0xFF6B7280),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(width: 8.w),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: severityStyle.backgroundColor,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  alert.severity,
                  style: TextStyle(
                    color: severityStyle.iconColor,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // --------------------------------------------------
          // Root Cause
          // --------------------------------------------------
          _InfoLine(
            icon: Icons.psychology_outlined,
            title: 'Root Cause',
            value: alert.rootCause,
          ),

          SizedBox(height: 10.h),

          // --------------------------------------------------
          // Energy Loss
          // --------------------------------------------------
          _InfoLine(
            icon: Icons.bolt_outlined,
            title: 'Energy Loss',
            value: '${alert.energyLossKwh.toStringAsFixed(2)} kWh',
          ),

          SizedBox(height: 10.h),

          // --------------------------------------------------
          // Financial Loss
          // --------------------------------------------------
          _InfoLine(
            icon: Icons.payments_outlined,
            title: 'Financial Loss',
            value: '${alert.financialLossEgp.toStringAsFixed(2)} EGP',
          ),

          SizedBox(height: 14.h),

          const Divider(height: 1, color: Color(0xFFE5E7EB)),

          SizedBox(height: 14.h),

          // --------------------------------------------------
          // Recommended Action
          // --------------------------------------------------
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.lightbulb_outline,
                color: const Color(0xFF123B70),
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recommended Action',
                      style: TextStyle(
                        color: const Color(0xFF6B7280),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      alert.recommendedAction,
                      style: TextStyle(
                        color: const Color(0xFF374151),
                        fontSize: 13.sp,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ============================================================
// INFO LINE
// ============================================================

class _InfoLine extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoLine({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: const Color(0xFF6B7280), size: 19.sp),
        SizedBox(width: 8.w),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$title: ',
                style: TextStyle(
                  color: const Color(0xFF6B7280),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Expanded(
                child: Text(
                  value,
                  style: TextStyle(
                    color: const Color(0xFF374151),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ============================================================
// SEVERITY STYLE
// ============================================================

class SeverityStyle {
  final Color backgroundColor;
  final Color borderColor;
  final Color iconColor;
  final IconData icon;

  const SeverityStyle({
    required this.backgroundColor,
    required this.borderColor,
    required this.iconColor,
    required this.icon,
  });

  static SeverityStyle of(String severity) {
    switch (severity.toLowerCase()) {
      case 'critical':
        return const SeverityStyle(
          backgroundColor: Color(0xFFFFE4E6),
          borderColor: Color(0xFFFCA5A5),
          iconColor: Color(0xFFDC2626),
          icon: Icons.error,
        );

      case 'high':
        return const SeverityStyle(
          backgroundColor: Color(0xFFFFE7E7),
          borderColor: Color(0xFFFCA5A5),
          iconColor: Color(0xFFDC2626),
          icon: Icons.error,
        );

      case 'medium':
        return const SeverityStyle(
          backgroundColor: Color(0xFFFFF7ED),
          borderColor: Color(0xFFFDBA74),
          iconColor: Color(0xFFEA580C),
          icon: Icons.error_outline,
        );

      default:
        return const SeverityStyle(
          backgroundColor: Color(0xFFEFF6FF),
          borderColor: Color(0xFFBFDBFE),
          iconColor: Color(0xFF2563EB),
          icon: Icons.info_outline,
        );
    }
  }
}

// ============================================================
// ERROR VIEW
// ============================================================

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: Colors.red, size: 55.sp),

            SizedBox(height: 16.h),

            Text(
              'Something went wrong',
              style: TextStyle(
                color: const Color(0xFF123B70),
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8.h),

            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 13.sp),
            ),

            SizedBox(height: 20.h),

            ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }
}
