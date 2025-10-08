import 'package:dio/dio.dart';

import '../utils/constants.dart';
import 'app_exceptions.dart';

class ExceptionHandler {
  static AppException handleException(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return AppException('Request timeout');
        case DioExceptionType.badResponse:
          return ServerException(
            error.response?.data['message'] ?? 'Server error',
            statusCode: error.response?.statusCode,
          );
        case DioExceptionType.cancel:
          return AppException('Request cancelled');
        case DioExceptionType.connectionError:
          return NoInternetException();
        case DioExceptionType.unknown:
          return AppException('Unknown error occurred');
        case DioExceptionType.badCertificate:
          // SHITAB TODO: Handle this case.
          throw UnimplementedError();
      }
    } else if (error is AppException) {
      return error;
    } else {
      return UnexpectedException(AppConstants.unexpectedErrorMessage);
    }
  }
}