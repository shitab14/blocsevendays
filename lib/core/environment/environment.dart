import 'package:flutter/foundation.dart';
import 'environment_config.dart';

class Environment {
  static String get env => const String.fromEnvironment('ENVIRONMENT');
  static bool get isDev => env == EnvironmentConfig.dev;
  static bool get isStage => env == EnvironmentConfig.stage;
  static bool get isProd => env == EnvironmentConfig.prod;
}