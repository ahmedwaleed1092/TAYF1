import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tayf/core/routing/routs.dart';
import 'package:tayf/fetures/chat_bot/cubit/copilot_cubit.dart';
import 'package:tayf/fetures/analytics/view/presentation/anomaly_detection_screen.dart';
import 'package:tayf/fetures/analytics/view/presentation/expected_vs_actual_screen.dart';
import 'package:tayf/fetures/analytics/view/presentation/root_analysis_screen.dart';
import 'package:tayf/fetures/chat_bot/view/presentation/chat_screen.dart';
import 'package:tayf/fetures/cleaning/view/cleaning_recommendation_screen.dart';
import 'package:tayf/fetures/financial/view/presentation/financial_scrreen.dart';
import 'package:tayf/fetures/home/view/presentation/home_screen.dart';
import 'package:tayf/fetures/on_boarding/view/presentation/on_boarding_screen.dart';
import 'package:tayf/fetures/smart_alarts/view/presentation/alarts_screen.dart';
import 'package:tayf/fetures/performance/presentation/Screens/performance_screen.dart';
import 'package:tayf/fetures/splash/view/presentation/splash_screen.dart';

class RoutConfig {
  static final GoRouter goRouter = GoRouter(
    initialLocation: Routs.splash,
    routes: [
      GoRoute(
        path: Routs.splash,
        name: Routs.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: Routs.peformance,
        name: Routs.peformance,
        builder: (context, state) => const PerformanceScreen(),
      ),
      GoRoute(
        path: Routs.onboarding,
        name: Routs.onboarding,
        builder: (context, state) => const OnBoardingScreen(),
      ),
      GoRoute(
        path: Routs.login,
        name: Routs.login,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        path: Routs.signUp,
        name: Routs.signUp,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        path: Routs.home,
        name: Routs.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: Routs.financialIncentives,
        name: Routs.financialIncentives,
        builder: (context, state) => const FinancialScreen(),
      ),
      GoRoute(
        path: Routs.cleaningRecommendation,
        name: Routs.cleaningRecommendation,
        builder: (context, state) => const CleaningRecommendationScreen(),
      ),
      GoRoute(
        path: Routs.alert,
        name: Routs.alert,
        builder: (context, state) => const PlantAlertsScreen(),
      ),
      GoRoute(
        path: Routs.chat,
        name: Routs.chat,
        builder: (context, state) => BlocProvider(
          create: (_) => CopilotCubit(),
          child: const AiCopilotScreen(),
        ),
      ),
      GoRoute(
        path: Routs.expectedVsActualScreen,
        name: Routs.expectedVsActualScreen,
        builder: (context, state) => const ExpectedVsActualScreen(),
      ),
      GoRoute(
        path: Routs.rootAnalysisScreen,
        name: Routs.rootAnalysisScreen,
        builder: (context, state) => const RootAnalsis(),
      ),
      GoRoute(
        path: Routs.anomalyDetectionScreen,
        name: Routs.anomalyDetectionScreen,
        builder: (context, state) => const AnomalyDetectionScreen(),
      ),
    ],
  );
}
