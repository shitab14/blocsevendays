import 'package:flutter/material.dart';

import '../../feature/main/presentation/pages/screen_main.dart';
import '../../feature/splash/presentation/pages/screen_splash.dart';

class AppRouteConstants {
  static const String splashPage = '/';
  static const String mainPage = '/main';

}

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteConstants.splashPage:
        return MaterialPageRoute(builder: (_) => SplashScreen());

      case AppRouteConstants.mainPage:
        return MaterialPageRoute(builder: (_) => MainScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}