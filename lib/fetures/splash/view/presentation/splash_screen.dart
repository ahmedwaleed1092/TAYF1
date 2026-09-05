import 'package:flutter/material.dart';
import 'package:tayf/fetures/splash/view/components/splash_body.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(child: SplashBody()),
    );
  }
}
