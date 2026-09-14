import 'package:flutter/material.dart';
import 'package:tayf/core/theme/app_colors.dart';
import 'package:tayf/core/theme/app_style.dart';

class AlertFilterTabs extends StatelessWidget {
  final List<String> filters;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const AlertFilterTabs({
    super.key,
    required this.filters,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.alertFilterBackground,
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
                  color: isSelected
                      ? AppColors.alertFilterSelected
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Text(
                  filters[index],
                  style: AppStyle.chatActionTitle.copyWith(
                    color: isSelected
                        ? Colors.white
                        : AppColors.alertFilterUnselectedText,
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
