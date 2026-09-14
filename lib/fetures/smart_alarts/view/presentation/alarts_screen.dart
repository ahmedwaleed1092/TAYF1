import 'package:flutter/material.dart';
import 'package:tayf/core/theme/app_colors.dart';
import 'package:tayf/core/theme/app_style.dart';
import 'package:tayf/fetures/smart_alarts/model/smart_alert.dart';
import 'package:tayf/fetures/smart_alarts/view/components/alert_card.dart';
import 'package:tayf/fetures/smart_alarts/view/components/alert_filter_tabs.dart';
import 'package:tayf/fetures/smart_alarts/view/components/alerts_bottom_nav_bar.dart';

class PlantAlertsScreen extends StatefulWidget {
  final List<SmartAlert> alerts;
  final int initialFilterIndex;
  final ValueChanged<SmartAlert>? onAlertTap;

  const PlantAlertsScreen({
    super.key,
    this.alerts = _defaultAlerts,
    this.initialFilterIndex = 0,
    this.onAlertTap,
  });

  static const List<SmartAlert> _defaultAlerts = [
    SmartAlert(
      severity: AlertSeverity.high,
      title: 'Inverter Overheating Detected',
      energyLoss: '320 KWh',
      financialLoss: '4,160 EGP',
      probableCause: 'Cooling fan failure or blocked ventilation',
      action: 'Inspect inverter cooling system immediately',
    ),
    SmartAlert(
      severity: AlertSeverity.high,
      title: 'Severe Soiling on Zone B3',
      energyLoss: '580 KWh',
      financialLoss: '7,540 EGP',
      probableCause: 'Dust accumulation after sandstorm event',
      action: 'Schedule emergency cleaning for Zone B3',
    ),
    SmartAlert(
      severity: AlertSeverity.medium,
      title: 'String Voltage Mismatch',
      energyLoss: '145 KWh',
      financialLoss: '1,885 EGP',
      probableCause: 'Partial shading or module degradation',
      action: 'Perform IV curve trace on affected strings',
    ),
    SmartAlert(
      severity: AlertSeverity.medium,
      title: 'Tracker Misalignment Warning',
      energyLoss: '210 KWh',
      financialLoss: '2,730 EGP',
      probableCause: 'Mechanical drift in tracker motor',
      action: 'Recalibrate tracker position sensors',
    ),
    SmartAlert(
      severity: AlertSeverity.info,
      title: 'Scheduled Maintenance Completed',
      isNormal: true,
    ),
    SmartAlert(
      severity: AlertSeverity.info,
      title: 'Weather Forecast: Clear Skies Next 5 Days',
      isNormal: true,
    ),
    SmartAlert(
      severity: AlertSeverity.high,
      title: 'Communication Loss – Meter #12',
      energyLoss: 'Unknown',
      financialLoss: 'Unknown',
      probableCause: 'Network cable damage or gateway failure',
      action: 'Check network connections at combiner box #12',
    ),
    SmartAlert(
      severity: AlertSeverity.medium,
      title: 'Below-Expected Generation Today',
      energyLoss: '95 KWh',
      financialLoss: '1,235 EGP',
      probableCause: 'Cloud cover exceeding forecast',
      action: 'Monitor through end of day, review tomorrow',
    ),
  ];

  @override
  State<PlantAlertsScreen> createState() => _PlantAlertsScreenState();
}

class _PlantAlertsScreenState extends State<PlantAlertsScreen> {
  late int _selectedFilter = widget.initialFilterIndex;
  final List<String> _filters = const ['All', 'Critical', 'High', 'Medium'];

  List<SmartAlert> get _filteredAlerts {
    final label = _filters[_selectedFilter];
    if (label == 'All') return widget.alerts;
    return widget.alerts.where((a) {
      return a.severity.name.toLowerCase() == label.toLowerCase();
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
        title: Text('Plant Alerts', style: AppStyle.alertAppBarTitle),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: AlertFilterTabs(
                filters: _filters,
                selectedIndex: _selectedFilter,
                onSelected: (i) => setState(() => _selectedFilter = i),
              ),
            ),
            Expanded(
              child: _filteredAlerts.isEmpty
                  ? Center(
                      child: Text(
                        'No alerts in this category',
                        style: AppStyle.alertEmptyText,
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                      itemCount: _filteredAlerts.length,
                      itemBuilder: (context, index) {
                        final alert = _filteredAlerts[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: GestureDetector(
                            onTap: () => widget.onAlertTap?.call(alert),
                            child: AlertCard(alert: alert),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
