import '../utils/constants.dart';

class AppException implements Exception {
  final String message;
  final int? statusCode;

  AppException(this.message, {this.statusCode});

  @override
  String toString() => message;
}

class NoInternetException extends AppException {
  NoInternetException() : super(AppConstants.noInternetMessage);
}

class ServerException extends AppException {
  ServerException(String message, {int? statusCode})
      : super(message, statusCode: statusCode);
}

class UnexpectedException extends AppException {
  UnexpectedException(String message) : super(message);
}