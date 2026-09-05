import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tayf/core/routing/routs.dart';
import 'package:tayf/fetures/home/view/presentation/home_screen.dart';
import 'package:tayf/fetures/on_boarding/view/presentation/on_boarding_screen.dart';
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
    ],
  );
}
