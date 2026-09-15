import 'package:flutter/material.dart';
import 'package:tayf/core/theme/app_colors.dart';
import 'package:tayf/core/theme/app_style.dart';
import 'package:tayf/fetures/analytics/view/components/expected_vs_actual_body.dart';

class ExpectedVsActualScreen extends StatelessWidget {
  const ExpectedVsActualScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primaryContrast,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryText),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Expected vs Actual', style: AppStyle.title),
      ),
      body: const ExpectedVsActualBody(),
    );
  }
}
