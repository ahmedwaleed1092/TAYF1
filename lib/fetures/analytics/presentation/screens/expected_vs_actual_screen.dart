import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:tayf/core/theme/app_colors.dart';
import 'package:tayf/core/theme/app_style.dart';
import 'package:tayf/fetures/analytics/presentation/widgets/NextNavigationButton.dart';
import 'package:tayf/fetures/analytics/presentation/widgets/PerformanceStatusCard.dart';
import 'package:tayf/fetures/analytics/presentation/widgets/PowerComparisonCard.dart';
import 'package:tayf/fetures/analytics/presentation/widgets/power_comparison_summary_card.dart';
import 'package:tayf/fetures/performance/presentation/widgets/time_range_item_widget.dart';

class ExpectedVsActualScreen extends StatefulWidget {
  const ExpectedVsActualScreen({super.key});

  @override
  State<ExpectedVsActualScreen> createState() => _ExpectedVsActualScreenState();
}

class _ExpectedVsActualScreenState extends State<ExpectedVsActualScreen> {
  String selectedRange = 'Day';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primaryContrast,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryText),
          onPressed: () {},
        ),
        title: Text('Expected vs Actual', style: AppStyle.title),
      ),
      body: Column(
        children: [
          // Time Range Filters
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: ['Today', '7 Days', '30 Days'].map((range) {
              return TimeRangeItemWidget(
                label: range,
                isSelected: selectedRange == range,
                onTap: () {
                  setState(() {
                    selectedRange = range;
                  });
                },
              );
            }).toList(),
          ),

          const Gap(20),
          const PowerComparisonSummaryCard(
            expectedPower: '82',
            actualPower: '69',
            deviation: '-15.8%',
          ),
        const Gap(20),
       const PowerComparisonCard(),
       const Gap(20),
const PerformanceStatusCard()
,Align(
  alignment: Alignment.centerRight,
  child: NextNavigationButton(
    onTap: () {
    },
  ),
)
        ],
      ),
    );
  }
}
