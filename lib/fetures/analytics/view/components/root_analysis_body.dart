import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tayf/core/routing/routs.dart';
import 'package:tayf/fetures/analytics/cubit/rootcuase_cubit.dart';
import 'package:tayf/fetures/analytics/view/components/anomaly_score_card.dart';
import 'package:tayf/fetures/analytics/view/components/detected_event_item.dart';
import 'package:tayf/fetures/analytics/view/components/next_navigation_button.dart';
import 'package:tayf/fetures/analytics/view/components/soiling_confidence_card.dart';

class RootAnalysisBody extends StatelessWidget {
  const RootAnalysisBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RootcuaseCubit, RootcuaseState>(
      listener: (context, state) {
        if (state is RootcuaseError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      },
      builder: (context, state) {
        // =====================================================
        // Loading
        // =====================================================

        if (state is RootcuaseLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        // =====================================================
        // Loaded
        // =====================================================

        if (state is RootcuaseLoaded) {
          final prediction = state.analysis.prediction;
          final input = state.analysis.input;

          // ===================================================
          // Deviation
          // ===================================================

          final deviationPercent = (prediction.deviation * 100).toStringAsFixed(
            1,
          );

          // ===================================================
          // Causes
          // ===================================================

          final causeEntries =
              prediction.causes.entries
                  .where((entry) => entry.value > 0)
                  .toList()
                ..sort((a, b) => b.value.compareTo(a.value));

          // ===================================================
          // Classification
          // ===================================================

          final classificationEntries =
              prediction.classification.entries
                  .where((entry) => entry.value > 0)
                  .toList()
                ..sort((a, b) => b.value.compareTo(a.value));

          // ===================================================
          // Status
          // ===================================================

          final isUnderperformance = prediction.status.toLowerCase().contains(
            'underperformance',
          );

          // ===================================================
          // UI
          // ===================================================

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // =================================================
                // Top Class + Confidence
                // =================================================

                SoilingConfidenceCard(
                  title: prediction.topClass,
                  percentage: prediction.confidence,
                  confidence: prediction.confidence,
                ),

                const Gap(24),

                // =================================================
                // Status
                // =================================================
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isUnderperformance
                        ? const Color(0xFFFFF7ED)
                        : const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isUnderperformance
                            ? Icons.warning_amber_rounded
                            : Icons.check_circle_outline,
                        color: isUnderperformance
                            ? const Color(0xFFEA580C)
                            : const Color(0xFF16A34A),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          prediction.status,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isUnderperformance
                                ? const Color(0xFFEA580C)
                                : const Color(0xFF16A34A),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const Gap(16),

                // =================================================
                // Problem Causes
                // =================================================
                const Text(
                  'Problem Causes',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F2B48),
                  ),
                ),

                const Gap(12),

                // =================================================
                // Power Deviation
                // =================================================
                DetectedEventItem(
                  title: 'Power Deviation',
                  subtitle: '$deviationPercent%',
                  severity: prediction.deviation.abs() > 0.2
                      ? EventSeverity.high
                      : EventSeverity.low,
                ),

                const Gap(12),

                // =================================================
                // Dynamic Causes
                // =================================================
                ...causeEntries.map(
                  (entry) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: DetectedEventItem(
                      title: entry.key,
                      subtitle: '${entry.value}%',
                      severity: entry.value >= 50
                          ? EventSeverity.high
                          : EventSeverity.low,
                    ),
                  ),
                ),

                // =================================================
                // Classification
                // =================================================
                ...classificationEntries.map(
                  (entry) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: DetectedEventItem(
                      title: entry.key,
                      subtitle: '${entry.value}%',
                      severity: entry.value >= 50
                          ? EventSeverity.high
                          : EventSeverity.low,
                    ),
                  ),
                ),

                const Gap(12),

                // =================================================
                // Anomaly Score
                // =================================================
                AnomalyScoreCard(score: prediction.confidence, total: 100),

                const Gap(12),

                // =================================================
                // Power Information
                // =================================================
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _PowerStat(
                        label: 'Actual',
                        value: '${prediction.pTotal.toStringAsFixed(0)} W',
                      ),
                      _PowerStat(
                        label: 'Expected',
                        value: '${prediction.pExpected.toStringAsFixed(0)} W',
                      ),
                      _PowerStat(
                        label: 'Irradiance',
                        value: '${input.irr.toStringAsFixed(0)} W/m²',
                      ),
                    ],
                  ),
                ),

                const Gap(12),

                // =================================================
                // Next Screen
                // =================================================
                Align(
                  alignment: Alignment.centerRight,
                  child: NextNavigationButton(
                    onTap: () {
                      context.pushNamed(Routs.anomalyDetectionScreen);
                    },
                  ),
                ),
              ],
            ),
          );
        }

        // =====================================================
        // Error
        // =====================================================

        if (state is RootcuaseError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 48,
                    color: Colors.redAccent,
                  ),
                  const Gap(12),
                  const Text(
                    'Failed to load root cause analysis',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const Gap(8),
                  Text(
                    state.error,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                  const Gap(16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<RootcuaseCubit>().fetchRootCause();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        // =====================================================
        // Initial / Fallback
        // =====================================================

        return const Center(child: Text('Waiting for data...'));
      },
    );
  }
}

// =============================================================
// Power Stat
// =============================================================

class _PowerStat extends StatelessWidget {
  final String label;
  final String value;

  const _PowerStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF64748B),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF0F2B48),
          ),
        ),
      ],
    );
  }
}
