import 'package:flutter/material.dart';
import 'package:tayf/core/theme/app_colors.dart';

class NextNavigationButton extends StatelessWidget {
  final VoidCallback? onTap;

  const NextNavigationButton({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: AppColors.border,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              'Next',
              style: TextStyle(
                color: Color(0xFF0F2B48),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 4),
            Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFF0F2B48),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
