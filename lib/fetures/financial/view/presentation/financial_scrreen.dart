import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tayf/core/common_widgets/main_elevated_button.dart';
import 'package:tayf/core/routing/routs.dart';
import 'package:tayf/core/theme/app_style.dart';
import 'package:tayf/fetures/energy/view/components/loss_card.dart';
import 'package:tayf/fetures/financial/cubit/financial_cubit.dart';
import 'package:tayf/fetures/financial/cubit/financial_state.dart';
import 'package:tayf/fetures/financial/models/financial_loss_model.dart';
import 'package:tayf/fetures/financial/view/components/category_chips_selector.dart';
import 'package:tayf/fetures/home/view/components/peformance_card.dart';

import '../components/tariff_breakdown_widget.dart';

class FinancialScreen extends StatefulWidget {
  const FinancialScreen({super.key});

  @override
  State<FinancialScreen> createState() => _FinancialScreenState();
}

class _FinancialScreenState extends State<FinancialScreen> {
  int _selectedIndex = 0;

  final List<String> categories = ["Net Metering", "Net Billing", "Licensed"];

  @override
  void initState() {
    super.initState();

    // Get financial loss data from API
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FinancialLossCubit>().getFinancialLoss(
        plantId: 1,
        tariffType: r'$',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Financial Incentives",
          style: TextStyle(
            color: const Color(0xff1A3B70),
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),

      body: BlocBuilder<FinancialLossCubit, FinancialLossState>(
        builder: (context, state) {
          if (state is FinancialLossLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is FinancialLossError) {
            return _ErrorWidget(
              message: state.error,
              onRetry: () {
                context.read<FinancialLossCubit>().getFinancialLoss(
                  plantId: 1,
                  tariffType: r'$',
                );
              },
            );
          }

          if (state is FinancialLossSuccess) {
            final data = state.financialLoss;

            return SingleChildScrollView(
              child: Section(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PerformanceRatioCard(
                        width: 160.w,
                        height: 80.h,
                        title: "Energy Loss",
                        value: "${data.energyLossKwh.toStringAsFixed(2)} KWH",
                      ),

                      PerformanceRatioCard(
                        width: 160.w,
                        height: 80.h,
                        title: "Tariff",
                        value:
                            "${data.tariffRate.toStringAsFixed(2)} ${data.currency}/kWh",
                      ),
                    ],
                  ),

                  Gap(16),

                  LossCard(
                    title: "Financial Loss",
                    value: data.estimatedLoss.toStringAsFixed(2),
                    unit: data.currency,
                    percentage: _calculateLossPercentage(data),
                  ),

                  Gap(8),

                  Padding(
                    padding: EdgeInsets.only(left: 4.w),
                    child: Text(
                      "Tariff Scheme",
                      style: AppStyle.graySimiBold16.copyWith(
                        color: const Color(0xff1A3B70),
                      ),
                    ),
                  ),

                  Gap(16),

                  CategoryChipsSelector(
                    categories: categories,
                    selectedIndex: _selectedIndex,
                    onSelected: (index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                  ),

                  Gap(16),

                  TariffBreakdownWidget(
                    title: "Energy Value",
                    value:
                        "${data.energyLossKwh.toStringAsFixed(2)} ${data.currency}",
                  ),

                  Gap(16),

                  MainElevatedButton(
                    width: double.infinity,
                    textOnButton: "View Cleaning Recommendation",
                    backgroundColor: const Color(0xff264DB3),
                    textColor: Colors.white,
                    textFontSize: 16,
                    onButtonTap: () {
                      context.pushNamed(Routs.cleaningRecommendation);
                    },
                  ),

                  Gap(100),
                ],
              ),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  String _calculateLossPercentage(FinancialLossModel data) {
    if (data.energyLossKwh <= 0 || data.tariffRate <= 0) {
      return "0%";
    }

    final percentage =
        (data.estimatedLoss / (data.energyLossKwh * data.tariffRate)) * 100;

    return "${percentage.toStringAsFixed(2)}%";
  }
}

// ============================================================
// ERROR WIDGET
// ============================================================

class _ErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorWidget({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: Colors.red, size: 55.sp),

            Gap(12),

            Text(
              "Something went wrong",
              style: TextStyle(
                color: const Color(0xff1A3B70),
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),

            Gap(8),

            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 13.sp),
            ),

            Gap(20),

            ElevatedButton(onPressed: onRetry, child: const Text("Retry")),
          ],
        ),
      ),
    );
  }
}
