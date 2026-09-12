import 'package:flutter/material.dart';
import 'package:tayf/fetures/cleaning/view/components/table_row.dart';

class EconomicAnalysisTable extends StatelessWidget {
  final String estimatedRecovery;
  final String recoveryValue;

  final String cleaningCost;
  final String netBenefit;

  const EconomicAnalysisTable({
    required this.estimatedRecovery,
    required this.recoveryValue,
    required this.cleaningCost,
    required this.netBenefit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE3E6EC)),
      ),
      child: Column(
        children: [
          TableRowScreen(label: 'Estimated Recovery', value: estimatedRecovery),
          const Divider(height: 1, color: Color(0xFFE3E6EC)),
          TableRowScreen(label: 'Recovery Value', value: recoveryValue),
          const Divider(height: 1, color: Color(0xFFE3E6EC)),
          TableRowScreen(label: 'Cleaing Cost', value: cleaningCost),
          const Divider(height: 1, color: Color(0xFFE3E6EC)),
          TableRowScreen(
            label: 'Net Benefit',
            value: netBenefit,
            highlighted: true,
          ),
        ],
      ),
    );
  }
}
