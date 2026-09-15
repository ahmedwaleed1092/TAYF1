import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tayf/core/common_widgets/main_elevated_button.dart';
import 'package:tayf/core/routing/routs.dart';
import 'package:tayf/core/theme/app_style.dart';
import 'package:tayf/fetures/energy/view/components/loss_card.dart';
import 'package:tayf/fetures/financial/view/components/category_chips_selector.dart';

import '../../../home/view/components/peformance_card.dart';
import '../components/tariff_breakdown_widget.dart';

class FinancialScreen extends StatefulWidget {
  const FinancialScreen({super.key});

  @override
  State<FinancialScreen> createState() => _FinancialScreenState();
}

class _FinancialScreenState extends State<FinancialScreen> {
  int _selectedIndex = 0;
  List<String> categories = ["Net Metering", "Net Billing", "Licensed"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Financial Incentives",
          style: TextStyle(
            color: Color(0xff1A3B70),
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
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
                  title: "Current Power",
                  value: "69 KWH",
                ),
                PerformanceRatioCard(
                  width: 160.w,
                  height: 80.h,
                  title: "Tariff",
                  value: "69 EGP/kWh",
                ),
              ],
            ),
            Gap(16),
            LossCard(
              title: "Financial Loss",
              value: "69 ",
              unit: 'EGP',
              percentage: '2.56 %',
            ),
            Gap(8),
            Padding(
              padding: EdgeInsets.only(left: 4.w),
              child: Text(
                "Tariff Scheme",
                style: AppStyle.graySimiBold16.copyWith(
                  color: Color(0xff1A3B70),
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
            TariffBreakdownWidget(title: "energy value", value: "16,120 EGP"),
            Gap(16),
            MainElevatedButton(
              width: double.infinity,
              textOnButton: "View Cleaning Recommendation",
              backgroundColor: Color(0xff264DB3),
              textColor: Colors.white,
              textFontSize: 16,
              onButtonTap: () {
                context.pushNamed(Routs.cleaningRecommendation);
              },
            ),
            Gap(100),
          ],
        ),
      ),
    );
  }
}
