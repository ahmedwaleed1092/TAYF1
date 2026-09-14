import 'package:flutter/material.dart';
import 'package:tayf/core/theme/app_colors.dart';
import 'package:tayf/core/theme/app_style.dart';

class AlertsBottomNavBar extends StatelessWidget {
  const AlertsBottomNavBar({super.key});

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
                Icon(item.$1, size: 22, color: AppColors.alertNavInactive),
                const SizedBox(height: 4),
                Text(item.$2, style: AppStyle.chatActionTitle),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
