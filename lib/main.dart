import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tayf/fetures/splash/view/presentation/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

// use muiltibolcProviderf for cubits on the screenUitilinit
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(),
          // routerConfig: RoutConfig.goRouter,
          home: const SplashScreen(),
        );
      },
    );
  }
}
