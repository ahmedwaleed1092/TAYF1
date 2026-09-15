import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tayf/core/routing/routs.dart';
import 'package:tayf/fetures/analytics/view/components/next_navigation_button.dart';
import 'package:tayf/fetures/analytics/view/components/performance_status_card.dart';
import 'package:tayf/fetures/analytics/view/components/power_comparison_card.dart';
import 'package:tayf/fetures/analytics/view/components/power_comparison_summary_card.dart';
import 'package:tayf/fetures/performance/presentation/widgets/time_range_item_widget.dart';

class ExpectedVsActualBody extends StatefulWidget {
  const ExpectedVsActualBody({super.key});

  @override
  State<ExpectedVsActualBody> createState() => _ExpectedVsActualBodyState();
}

class _ExpectedVsActualBodyState extends State<ExpectedVsActualBody> {
  String selectedRange = 'Day';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
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
          const PerformanceStatusCard(),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0, bottom: 16.0),
              child: NextNavigationButton(
                onTap: () {
                  GoRouter.of(context).pushNamed(Routs.rootAnalysisScreen);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
