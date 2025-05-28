import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException({required this.message, this.statusCode});

  factory ApiException.fromDioError(DioException error) {
    String message;
    int? statusCode;

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        message = 'Connection timeout';
        break;
      case DioExceptionType.badResponse:
        message = error.response?.statusMessage ?? 'Server error';
        statusCode = error.response?.statusCode;
        break;
      case DioExceptionType.cancel:
        message = 'Request cancelled';
        break;
      default:
        message = 'Network error occurred: ${error.message}';
    }

    return ApiException(message: message, statusCode: statusCode);
  }

  @override
  String toString() => 'ApiException: $message (Code: $statusCode)';
}
