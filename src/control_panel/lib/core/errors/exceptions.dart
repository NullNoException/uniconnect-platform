import '../network/api_exception.dart';

/// Exception thrown when a server error occurs
class ServerException implements Exception {
  final String message;
  final int? statusCode;

  ServerException({required this.message, this.statusCode});

  factory ServerException.fromApiException(ApiException apiException) {
    return ServerException(
      message: apiException.message,
      statusCode: apiException.statusCode,
    );
  }

  @override
  String toString() => 'ServerException: $message (Code: $statusCode)';
}

/// Exception thrown when a cache operation fails
class CacheException implements Exception {
  final String message;

  CacheException({required this.message});

  @override
  String toString() => 'CacheException: $message';
}

/// Exception thrown when a validation error occurs
class ValidationException implements Exception {
  final String message;
  final Map<String, List<String>>? errors;

  ValidationException({required this.message, this.errors});

  @override
  String toString() => 'ValidationException: $message';
}

/// Exception thrown when authentication fails
class AuthenticationException implements Exception {
  final String message;

  AuthenticationException({required this.message});

  @override
  String toString() => 'AuthenticationException: $message';
}

/// Exception thrown when authorization fails
class AuthorizationException implements Exception {
  final String message;

  AuthorizationException({required this.message});

  @override
  String toString() => 'AuthorizationException: $message';
}

/// Exception thrown when a resource is not found
class NotFoundException implements Exception {
  final String message;

  NotFoundException({required this.message});

  @override
  String toString() => 'NotFoundException: $message';
}
