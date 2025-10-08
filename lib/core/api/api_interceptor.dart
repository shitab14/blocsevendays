import 'package:dio/dio.dart';

import '../utils/logger.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    AppLogger.debug('Request: ${options.method} ${options.uri}');
    AppLogger.debug('Headers: ${options.headers}');
    AppLogger.debug('Body: ${options.data}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    AppLogger.debug('Response: ${response.statusCode} ${response.requestOptions.uri}');
    AppLogger.debug('Body: ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AppLogger.error('Error: ${err.type} ${err.requestOptions.uri}', error: err);
    super.onError(err, handler);
  }
}