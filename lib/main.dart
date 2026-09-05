import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tayf/core/routing/routs_config.dart';
import 'package:tayf/fetures/splash/view/presentation/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

// use muiltibolcProvider for cubits on the screenUitilinit
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,

          theme: ThemeData(
            textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          ),
          routerConfig: RoutConfig.goRouter,
        );
      },
      child: const SplashScreen(),
    );
  }
}
