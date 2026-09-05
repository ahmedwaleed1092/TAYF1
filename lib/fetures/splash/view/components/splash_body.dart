import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tayf/core/app_assets.dart';
import 'package:tayf/core/routing/routs.dart';

class SplashBody extends StatefulWidget {
  const SplashBody({super.key});

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slideAnimation;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(animationController);
    animationController.forward();

    Future.delayed(const Duration(seconds: 3), () {
      GoRouter.of(context).push(Routs.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedBuilder(
          animation: animationController,
          builder: (context, child) {
            return SlideTransition(position: slideAnimation, child: child);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100.r),
            child: Image.asset(AppAssets.logo, height: 300.h, width: 300.w),
          ),
        ),
      ],
    );
  }
}
