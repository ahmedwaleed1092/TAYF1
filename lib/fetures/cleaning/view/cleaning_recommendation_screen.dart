import 'package:flutter/material.dart';
import 'package:tayf/fetures/cleaning/view/components/bottom_action_button.dart';
import 'package:tayf/fetures/cleaning/view/components/econonic_analysis_table.dart';
import 'package:tayf/fetures/cleaning/view/components/rational_item.dart';

class CleaningRecommendationScreen extends StatelessWidget {
  final String estimatedRecovery;
  final String recoveryValue;
  final String cleaningCost;
  final String netBenefit;
  final List<String> rationale;

  const CleaningRecommendationScreen({
    super.key,
    this.estimatedRecovery = '120 KWh',
    this.recoveryValue = '1,560 EGP',
    this.cleaningCost = '500 EGP',
    this.netBenefit = '1,060 EGP',
    this.rationale = const [
      'Soiling level significant (12.5%)',
      'High financial impact (16,120 EGP)',
      'Positive net benefit (1,060 EGP)',
    ],
  });

  static const Color titleColor = Color(0xFF16326B);
  static const Color labelColor = Color(0xFF6B7280);
  static const Color green = Color(0xFF1E8E3E);
  static const Color greenBg = Color(0xFFE8F7EC);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.6,
        centerTitle: false,
        leading: const BackButton(color: titleColor),
        title: const Text(
          'Cleaning Recommendation',
          style: TextStyle(
            color: titleColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RecommendationBanner(),
                    const SizedBox(height: 24),
                    const Text(
                      'Economic Analysis',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: titleColor,
                      ),
                    ),

                    const SizedBox(height: 12),
                    EconomicAnalysisTable(
                      estimatedRecovery: estimatedRecovery,
                      recoveryValue: recoveryValue,
                      cleaningCost: cleaningCost,
                      netBenefit: netBenefit,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Decision Rationale',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: titleColor,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...rationale.map((r) => RationaleItem(text: r)),
                  ],
                ),
              ),
            ),
            BottomActionButton(label: 'Create Work Order', onTap: () {}),
          ],
        ),
      ),
    );
  }
}

class RecommendationBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: CleaningRecommendationScreen.greenBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFBFE8CC)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: CleaningRecommendationScreen.green,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.bolt, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 10),
              const Text(
                'Recommendation',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,

                  color: CleaningRecommendationScreen.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Text(
            'CLEAN NOW',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w900,
              color: CleaningRecommendationScreen.green,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Net benefit exceeds cleaning',
            style: TextStyle(
              fontSize: 14,
              color: CleaningRecommendationScreen.labelColor,
            ),
          ),
        ],
      ),
    );
  }
}
