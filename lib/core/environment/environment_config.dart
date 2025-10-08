abstract class EnvironmentConfig {
  static const String dev = 'dev';
  static const String stage = 'stage';
  static const String prod = 'prod';

  static String get baseUrl {
    switch (const String.fromEnvironment('ENVIRONMENT')) {
      case dev:
        return 'https://newsapi.org/v2/';
      case stage:
        return 'https://newsapi.org/v2/';
      case prod:
        return 'https://newsapi.org/v2/';
      default:
        return 'https://newsapi.org/v2/';
    }
  }

  static String get api_key_baseUrl {
    switch (const String.fromEnvironment('ENVIRONMENT')) {
      case dev:
        return 'https://shitab14.github.io/jsons';
      case stage:
        return 'https://shitab14.github.io/jsons';
      case prod:
        return 'https://shitab14.github.io/jsons';
      default:
        return 'https://shitab14.github.io/jsons';
    }
  }

}