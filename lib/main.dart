import 'package:blocsevendays/feature/splash/presentation/bloc/bloc_splash.dart';
import 'package:flutter/material.dart';

import 'core/di/injector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/navigation/app_router.dart';
import 'core/utils/app_theme.dart';
import 'feature/main/presentation/bloc/bloc_main.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependency injection
  Injector.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => Injector.get<SplashBloc>(),
        ),
        BlocProvider(
          create: (context) => Injector.get<MainBloc>(),
        ),
      ],
      child: MaterialApp(
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: AppRouteConstants.splashPage,
      ),
    );
  }
}