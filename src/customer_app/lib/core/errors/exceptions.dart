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
  const NetworkException(super.message, {super.code, super.cause});
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
    super.message, {
    this.fieldErrors,
    super.code,
    super.cause,
  });
}

class AuthenticationException extends AppException {
  const AuthenticationException(super.message, {super.code, super.cause});
}

class PermissionException extends AppException {
  const PermissionException(super.message, {super.code, super.cause});
}

class NotFoundException extends AppException {
  const NotFoundException(super.message, {super.code, super.cause});
}
