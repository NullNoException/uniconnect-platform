abstract class AppException implements Exception {
  final String message;
  final String? code;
  final Exception? cause;

  const AppException(this.message, {this.code, this.cause});

  @override
  String toString() =>
      'AppException: $message${code != null ? ' (code: $code)' : ''}';
}

class NetworkException extends AppException {
  const NetworkException(String message, {String? code, Exception? cause})
    : super(message, code: code, cause: cause);
}

class ServerException extends AppException {
  final int? statusCode;

  const ServerException({
    this.statusCode,
    String? code,
    Exception? cause,
    required String message,
  }) : super(message, code: code, cause: cause);

  @override
  String toString() =>
      'ServerException: $message (status: $statusCode)${code != null ? ' (code: $code)' : ''}';
}

class CacheException extends AppException {
  const CacheException({
    required String message,
    String? code,
    Exception? cause,
  }) : super(message, code: code, cause: cause);
}

class ValidationException extends AppException {
  final Map<String, List<String>>? fieldErrors;

  const ValidationException(
    String message, {
    this.fieldErrors,
    String? code,
    Exception? cause,
  }) : super(message, code: code, cause: cause);
}

class AuthenticationException extends AppException {
  const AuthenticationException(
    String message, {
    String? code,
    Exception? cause,
  }) : super(message, code: code, cause: cause);
}

class PermissionException extends AppException {
  const PermissionException(String message, {String? code, Exception? cause})
    : super(message, code: code, cause: cause);
}

class NotFoundException extends AppException {
  const NotFoundException(String message, {String? code, Exception? cause})
    : super(message, code: code, cause: cause);
}
