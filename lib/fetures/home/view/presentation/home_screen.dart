import 'package:flutter/material.dart';
import 'package:tayf/fetures/energy/view/presentation/energy_screen.dart';
import 'package:tayf/fetures/financial/view/presentation/financial_scrreen.dart';
import 'package:tayf/fetures/home/view/components/body_home_screen.dart';
import 'package:tayf/fetures/home/view/components/tayf_bottom_nav_bar.dart';
import 'package:tayf/fetures/soillingAnalysis/view/presentation/solling_analysis_screen.dart';
import 'package:tayf/fetures/performance/presentation/Screens/performance_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const BodyHomeScreen(),
    const PerformanceScreen(),
    const EnergyScreen(),
    const SoilingAnalysisScreen(),
    const FinancialScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        extendBody: true,
        body: IndexedStack(index: _currentIndex, children: _screens),
        bottomNavigationBar: TayfBottomNavBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
        ),
      ),
    );
  }
}
