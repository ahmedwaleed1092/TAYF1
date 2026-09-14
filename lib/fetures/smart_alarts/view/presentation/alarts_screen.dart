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
    required this.energyLoss,
    required this.financialLoss,
    required this.probableCause,
    required this.action,
    this.isNormal = false,
  });
}

class SmartAlertsScreen extends StatefulWidget {
  const SmartAlertsScreen({super.key});

  @override
  State<SmartAlertsScreen> createState() => _SmartAlertsScreenState();
}

class _SmartAlertsScreenState extends State<SmartAlertsScreen> {
  int _selectedFilter = 0;
  final List<String> _filters = const ['All', 'Critical', 'High', 'Medium'];

  static const Color titleColor = AppStyle.primaryColor;

  final List<SmartAlert> _alerts = const [
    SmartAlert(
      severity: AlertSeverity.high,
      title: 'INV-04 underperforming by 18%',
      energyLoss: '450 kWh',
      financialLoss: '5,850 EGP',
      probableCause: 'Inverter Issue',
      action: 'Inspect inverter',
    ),
    SmartAlert(
      severity: AlertSeverity.medium,
      title: 'Soiling level high',
      energyLoss: '320 kWh',
      financialLoss: '4,160 EGP',
      probableCause: 'Soiling',
      action: 'Schedule cleaning',
    ),
    SmartAlert(
      severity: AlertSeverity.high,
      title: 'String voltage low',
      energyLoss: '210 kWh',
      financialLoss: '2,730 EGP',
      probableCause: 'Electrical',
      action: 'Check connections',
    ),
    SmartAlert(
      severity: AlertSeverity.high,
      title: 'High temperature alert',
      energyLoss: '120 kWh',
      financialLoss: '1,560 EGP',
      probableCause: 'Temperature Issue',
      action: 'Check temperature',
    ),
    SmartAlert(
      severity: AlertSeverity.medium,
      title: 'Communication failure',
      energyLoss: '180 kWh',
      financialLoss: '2,340 EGP',
      probableCause: 'Communication Issue',
      action: 'Check communication',
    ),
    SmartAlert(
      severity: AlertSeverity.info,
      title: 'Low irradiance',
      energyLoss: '90 kWh',
      financialLoss: '1,170 EGP',
      probableCause: 'Irradiance Issue',
      action: 'Check irradiance',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.6,
        leading: const BackButton(color: titleColor),
        title: const Text(
          'Smart Alerts',
          style: appBarTitleStyle,
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
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                itemCount: _alerts.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: _AlertCard(alert: _alerts[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const _SmartAlertsBottomNavBar(),
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

  static const Color selectedColor = AppStyle.primaryColor;
  static const Color unselectedText = AppStyle.filterTabUnselectedText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppStyle.filterTabBackground,
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
                  color: isSelected ? selectedColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Text(
                  filters[index],
                  style: filterTabStyle.copyWith(
                    color: isSelected ? Colors.white : filterTabUnselectedText,
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

  static const Color titleColor = AppStyle.primaryColor;
  static const Color labelColor = AppStyle.labelColor;

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
                    style: alertLabelStyle.copyWith(color: style.badgeText),
                  ),
                )
              else
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: style.iconColor.withOpacity(0.4)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    style.label,
                    style: alertLabelStyle.copyWith(color: style.iconColor),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            alert.title,
            style: alertTitleStyle,
          ),
          const SizedBox(height: 8),
          if (alert.isNormal)
            const Text(
              'No impact . Normal',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: labelColor,
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
        style: AppStyle.infoLineLabelStyle,
        children: [
          TextSpan(
            text: '$label - ',
            style: AppStyle.infoLineLabelStyle,
          ),
          TextSpan(
            text: value,
            style: AppStyle.infoLineValueStyle,
          ),
        ],
      ),
    );
  }
}

class _SmartAlertsBottomNavBar extends StatelessWidget {
  const _SmartAlertsBottomNavBar();

  static const Color activeColor = AppStyle.primaryColor;
  static const Color inactiveColor = AppStyle.bottomNavInactiveColor;

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
                Icon(item.$1, size: 22, color: inactiveColor),
                const SizedBox(height: 4),
                Text(
                  item.$2,
                  style: bottomNavTextStyle.copyWith(color: inactiveColor),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
