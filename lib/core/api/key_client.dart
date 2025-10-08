import 'package:dio/dio.dart';

import '../environment/environment_config.dart';
import '../exceptions/exception_handler.dart';
import 'api_interceptor.dart';

class KeyClient {
  late final Dio dio;

  KeyClient() {
    dio = Dio();
    dio.options.baseUrl = EnvironmentConfig.api_key_baseUrl;
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);
    dio.interceptors.add(ApiInterceptor());
  }

  Future<Response> get(
      String path, {
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    try {
      return await dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw ExceptionHandler.handleException(e);
    }
  }
}