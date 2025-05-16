import 'exceptions.dart';

abstract class Failure {
  final String message;
  final String? code;

  const Failure(this.message, {this.code});
}

class NetworkFailure extends Failure {
  const NetworkFailure(String message, {String? code})
    : super(message, code: code);
}

class ServerFailure extends Failure {
  final int? statusCode;

  const ServerFailure(String message, {this.statusCode, String? code})
    : super(message, code: code);
}

class CacheFailure extends Failure {
  const CacheFailure(String message, {String? code})
    : super(message, code: code);
}

class ValidationFailure extends Failure {
  final Map<String, List<String>>? fieldErrors;

  const ValidationFailure(String message, {this.fieldErrors, String? code})
    : super(message, code: code);
}

class AuthenticationFailure extends Failure {
  const AuthenticationFailure(String message, {String? code})
    : super(message, code: code);
}

class PermissionFailure extends Failure {
  const PermissionFailure(String message, {String? code})
    : super(message, code: code);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure(String message, {String? code})
    : super(message, code: code);
}

// Helper function to map exceptions to failures
Failure exceptionToFailure(Exception exception) {
  if (exception is NetworkException) {
    return NetworkFailure(exception.message, code: exception.code);
  } else if (exception is ServerException) {
    return ServerFailure(
      exception.message,
      statusCode: exception.statusCode,
      code: exception.code,
    );
  } else if (exception is CacheException) {
    return CacheFailure(exception.message, code: exception.code);
  } else if (exception is ValidationException) {
    return ValidationFailure(
      exception.message,
      fieldErrors: exception.fieldErrors,
      code: exception.code,
    );
  } else if (exception is AuthenticationException) {
    return AuthenticationFailure(exception.message, code: exception.code);
  } else if (exception is PermissionException) {
    return PermissionFailure(exception.message, code: exception.code);
  } else if (exception is NotFoundException) {
    return NotFoundFailure(exception.message, code: exception.code);
  } else {
    return ServerFailure(exception.toString());
  }
}
