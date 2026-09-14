import 'package:flutter/material.dart';
import 'package:tayf/core/theme/app_style.dart';

enum AlertSeverity { high, medium, info }

class SmartAlert {
  final AlertSeverity severity;
  final String title;
  final String energyLoss;
  final String financialLoss;
  final String probableCause;
  final String action;
  final bool isNormal;

  const SmartAlert({
    required this.severity,
    required this.title,
    this.energyLoss = '',
    this.financialLoss = '',
    this.probableCause = '',
    this.action = '',
    this.isNormal = false,
  });
}

class PlantAlertsScreen extends StatefulWidget {
  final List<SmartAlert> alerts;
  final int initialFilterIndex;
  final ValueChanged<SmartAlert>? onAlertTap;

  const PlantAlertsScreen({
    super.key,
    required this.alerts,
    this.initialFilterIndex = 0,
    this.onAlertTap,
  });

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
        leading: const BackButton(color: AppStyle.alertTitleColor),
        title: const Text(
          'Plant Alerts',
          style: TextStyle(
            color: AppStyle.alertTitleColor,
            fontWeight: FontWeight.bold,
            fontSize: 19,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: _FilterTabs(
                filters: _filters,
                selectedIndex: _selectedFilter,
                onSelected: (i) => setState(() => _selectedFilter = i),
              ),
            ),
            Expanded(
              child: _filteredAlerts.isEmpty
                  ? const Center(
                      child: Text(
                        'No alerts in this category',
                        style: TextStyle(color: AppStyle.alertLabelColor),
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
                            child: _AlertCard(alert: alert),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const _PlantAlertsBottomNavBar(),
    );
  }
}

class _FilterTabs extends StatelessWidget {
  final List<String> filters;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const _FilterTabs({
    required this.filters,
    required this.selectedIndex,
    required this.onSelected,
  });



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppStyle.alertFilterBackgroundColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: List.generate(filters.length, (index) {
          final bool isSelected = index == selectedIndex;
          return Expanded(
            child: GestureDetector(
              onTap: () => onSelected(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? AppStyle.alertFilterSelectedColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Text(
                  filters[index],
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : AppStyle.alertFilterUnselectedTextColor,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _SeverityStyle {
  final Color background;
  final Color border;
  final Color badgeBg;
  final Color badgeText;
  final Color iconColor;
  final IconData icon;
  final String label;

  const _SeverityStyle({
    required this.background,
    required this.border,
    required this.badgeBg,
    required this.badgeText,
    required this.iconColor,
    required this.icon,
    required this.label,
  });

  static _SeverityStyle of(AlertSeverity severity) {
    switch (severity) {
      case AlertSeverity.high:
        return const _SeverityStyle(
          background: AppStyle.alertHighBackground,
          border: AppStyle.alertHighBorder,
          badgeBg: AppStyle.alertHighBadgeBg,
          badgeText: AppStyle.alertHighBadgeText,
          iconColor: AppStyle.alertHighIconColor,
          icon: Icons.error,
          label: 'High',
        );
      case AlertSeverity.medium:
        return const _SeverityStyle(
          background: AppStyle.alertMediumBackground,
          border: AppStyle.alertMediumBorder,
          badgeBg: AppStyle.alertMediumBadgeBg,
          badgeText: AppStyle.alertMediumBadgeText,
          iconColor: AppStyle.alertMediumIconColor,
          icon: Icons.error_outline,
          label: 'Medium',
        );
      case AlertSeverity.info:
        return const _SeverityStyle(
          background: AppStyle.alertInfoBackground,
          border: AppStyle.alertInfoBorder,
          badgeBg: AppStyle.alertInfoBadgeBg,
          badgeText: AppStyle.alertInfoBadgeText,
          iconColor: AppStyle.alertInfoIconColor,
          icon: Icons.check_circle_outline,
          label: 'Info',
        );
    }
  }
}

class _AlertCard extends StatelessWidget {
  final SmartAlert alert;

  const _AlertCard({required this.alert});



  @override
  Widget build(BuildContext context) {
    final style = _SeverityStyle.of(alert.severity);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: style.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: style.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(style.icon, color: style.iconColor, size: 20),
              const SizedBox(width: 8),
              if (alert.severity != AlertSeverity.info)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: style.badgeBg,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    style.label,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: style.badgeText,
                    ),
                  ),
                )
              else
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: style.iconColor.withOpacity(0.4)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    style.label,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: style.iconColor,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            alert.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppStyle.alertTitleColor,
            ),
          ),
          const SizedBox(height: 8),
          if (alert.isNormal)
            const Text(
              'No impact . Normal',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppStyle.alertLabelColor,
              ),
            )
          else ...[
            _InfoLine(label: 'Estimated Energy Loss', value: alert.energyLoss),
            const SizedBox(height: 6),
            _InfoLine(
              label: 'Estimated Financial Loss',
              value: alert.financialLoss,
            ),
            const SizedBox(height: 6),
            _InfoLine(label: 'Probable Cause', value: alert.probableCause),
            const SizedBox(height: 6),
            _InfoLine(label: 'Action', value: alert.action),
          ],
        ],
      ),
    );
  }
}

class _InfoLine extends StatelessWidget {
  final String label;
  final String value;

  const _InfoLine({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        children: [
          TextSpan(
            text: '$label - ',
            style: const TextStyle(color: AppStyle.alertLabelColor),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(color: AppStyle.alertTitleColor),
          ),
        ],
      ),
    );
  }
}

class _PlantAlertsBottomNavBar extends StatelessWidget {
  const _PlantAlertsBottomNavBar();



  @override
  Widget build(BuildContext context) {
    final items = [
      (Icons.home_outlined, 'Home'),
      (Icons.bar_chart_rounded, 'Performance'),
      (Icons.auto_awesome, 'AI Copilot'),
      (Icons.bolt_outlined, 'Energy'),
      (Icons.person_outline, 'Profile'),
    ];

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey.shade200)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items.map((item) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(item.$1, size: 22, color: AppStyle.alertBottomNavInactiveColor),
                const SizedBox(height: 4),
                Text(
                  item.$2,
                  style: const TextStyle(fontSize: 10.5, color: AppStyle.alertBottomNavInactiveColor),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
