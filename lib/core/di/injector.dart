import 'package:get_it/get_it.dart';
import 'module.dart';

class Injector {
  static void init() {
    AppModule.setup();
  }

  static T get<T extends Object>() {
    return GetIt.instance.get<T>();
  }
}