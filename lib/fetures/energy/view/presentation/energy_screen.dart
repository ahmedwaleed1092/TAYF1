import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tayf/core/common_widgets/main_elevated_button.dart';
import 'package:tayf/core/routing/routs.dart';
import 'package:tayf/fetures/energy/view/components/energy_loss_card.dart';
import 'package:tayf/fetures/energy/view/components/loss_card.dart';
import 'package:tayf/fetures/energy/view/components/loss_presentage_card.dart';

import '../components/energy_comparsion_card.dart';

class EnergyScreen extends StatelessWidget {
  const EnergyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Section(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            children: [
              EnergyComparisonCard(
                expectedValue: "9,500",
                expectedUnit: "kWh",
                actualValue: "8,260",
                actualUnit: "kWh",
              ),
              Gap(18.h),
              LossCard(
                title: "Loss",
                value: "1,240",
                unit: "kWh",
                percentage: "15%",
              ),
              Gap(18.h).column,
              LossAttributionCard(
                items: [
                  LossItem(
                    name: 'Soiling',
                    value: 1240,
                    percent: 100,
                    color: Colors.lightBlue,
                  ),
                  LossItem(
                    name: 'Inverter',
                    value: 550,
                    percent: 5,
                    color: Colors.orange,
                  ),
                  LossItem(
                    name: 'other',
                    value: 0,
                    percent: 5,
                    color: Colors.blueGrey,
                  ),
                ],
              ),
              Gap(16.h),
              EnergyLossCard(
                value: "1,240",
                unit: "kWh",
                percentChange: "-13.1%",
              ),
              Gap(8.h),
              MainElevatedButton(
                textOnButton: "discover finaical incentives",
                width: 200,
                borderRadius: 10,
                height: 30,
                onButtonTap: () {
                  GoRouter.of(context).pushNamed(Routs.financialIncentives);
                },
                backgroundColor: Color(0xffF9FAFB),
                textColor: Color(0xff3B2FC9),
                textFontWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
