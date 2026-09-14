import 'package:flutter/material.dart';
import 'package:tayf/core/theme/app_colors.dart';
import 'package:tayf/core/theme/app_style.dart';
import 'package:tayf/fetures/smart_alarts/model/smart_alert.dart';

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

  static SeverityStyle of(AlertSeverity severity) {
    switch (severity) {
      case AlertSeverity.high:
        return const SeverityStyle(
          background: AppColors.alertHighBackground,
          border: AppColors.alertHighBorder,
          badgeBg: AppColors.alertHighBadgeBg,
          badgeText: AppColors.alertHighBadgeText,
          iconColor: AppColors.alertHighIcon,
          icon: Icons.error,
          label: 'High',
        );
      case AlertSeverity.medium:
        return const SeverityStyle(
          background: AppColors.alertMediumBackground,
          border: AppColors.alertMediumBorder,
          badgeBg: AppColors.alertMediumBadgeBg,
          badgeText: AppColors.alertMediumBadgeText,
          iconColor: AppColors.alertMediumIcon,
          icon: Icons.error_outline,
          label: 'Medium',
        );
      case AlertSeverity.info:
        return const SeverityStyle(
          background: AppColors.alertInfoBackground,
          border: AppColors.alertInfoBorder,
          badgeBg: AppColors.alertInfoBadgeBg,
          badgeText: AppColors.alertInfoBadgeText,
          iconColor: AppColors.alertInfoIcon,
          icon: Icons.check_circle_outline,
          label: 'Info',
        );
    }
  }
}

class AlertCard extends StatelessWidget {
  final SmartAlert alert;

  const AlertCard({super.key, required this.alert});

  @override
  Widget build(BuildContext context) {
    final style = SeverityStyle.of(alert.severity);

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
                    style: AppStyle.alertBadgeLabel.copyWith(
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
                    border: Border.all(
                      color: style.iconColor.withOpacity(0.4),
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    style.label,
                    style: AppStyle.alertBadgeLabel.copyWith(
                      color: style.iconColor,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Text(alert.title, style: AppStyle.alertCardTitle),
          const SizedBox(height: 8),
          if (alert.isNormal)
            Text('No impact . Normal', style: AppStyle.alertNormalText)
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
        children: [
          TextSpan(
            text: '$label - ',
            style: AppStyle.alertInfoLineLabel,
          ),
          TextSpan(
            text: value,
            style: AppStyle.alertInfoLineValue,
          ),
        ],
      ),
    );
  }
}
