import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tayf/core/api/api_helper.dart';
import 'package:tayf/core/routing/routs_config.dart';
import 'package:tayf/fetures/analytics/cubit/rootcuase_cubit.dart';
import 'package:tayf/fetures/chat_bot/cubit/copilot_cubit.dart';
import 'package:tayf/fetures/financial/cubit/financial_cubit.dart';
import 'package:tayf/fetures/home/cubit/dashboard_data_cubit.dart';
import 'package:tayf/fetures/home/cubit/wither_cubit.dart';
import 'package:tayf/fetures/smart_alarts/cubit/alerts_cubit.dart';
import 'package:tayf/fetures/splash/view/presentation/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
  DioHelper();
}

// use muiltibolcProviderf for cubits on the screenUitilinit
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CopilotCubit>(create: (context) => CopilotCubit()),
        BlocProvider<WitherCubit>(
          create: (context) => WitherCubit()..getWeatherData('Beni Suef'),
        ),
        BlocProvider<RootcuaseCubit>(
          create: (context) => RootcuaseCubit(rowIndex: 1),
        ),
        BlocProvider<AlertsCubit>(
          create: (context) => AlertsCubit()..getAlerts(),
        ),
        BlocProvider<TelemetryCubit>(
          create: (context) =>
              TelemetryCubit(plantId: 1, inverterId: 1)
                ..fetchTelemetry(page: 1, pageSize: 50),
        ),
        BlocProvider<FinancialLossCubit>(
          create: (context) => FinancialLossCubit(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(),
            routerConfig: RoutConfig.goRouter,
          );
        },
      ),
    );
  }
}
