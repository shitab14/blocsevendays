import 'package:dio/dio.dart';

import '../environment/environment_config.dart';
import '../exceptions/exception_handler.dart';
import 'api_interceptor.dart';

class ApiClient {
  late final Dio dio;

  ApiClient(Dio _dio) {
    dio = _dio;
    _dio.options.baseUrl = EnvironmentConfig.baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    _dio.interceptors.add(ApiInterceptor());
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