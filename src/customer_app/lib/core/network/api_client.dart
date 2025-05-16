import 'dart:io';

import 'package:dio/dio.dart';
import '../constants/app_constants.dart';
import '../errors/exceptions.dart';

class ApiClient {
  final Dio _dio;

  ApiClient(this._dio) {
    _dio.options.baseUrl = AppConstants.baseUrl;
    _dio.options.connectTimeout = Duration(
      milliseconds: AppConstants.apiTimeoutDuration,
    );
    _dio.options.receiveTimeout = Duration(
      milliseconds: AppConstants.apiTimeoutDuration,
    );

    // Add interceptors for logging, token handling, etc.
    _dio.interceptors.add(_createLoggingInterceptor());
  }

  // Create a new instance with auth token
  ApiClient withToken(String token) {
    final newDio = Dio(_dio.options);
    newDio.options.headers['Authorization'] = 'Bearer $token';
    return ApiClient(newDio);
  }

  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<dynamic> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<dynamic> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<dynamic> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<dynamic> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return NetworkException('Connection timeout', cause: error);
        case DioExceptionType.connectionError:
          return NetworkException('Connection error', cause: error);
        case DioExceptionType.badCertificate:
          return NetworkException('Bad certificate', cause: error);
        case DioExceptionType.badResponse:
          return _handleBadResponse(error);
        case DioExceptionType.cancel:
          return NetworkException('Request was cancelled', cause: error);
        case DioExceptionType.unknown:
          if (error.error is SocketException) {
            return NetworkException('No internet connection', cause: error);
          }
          return ServerException(
            message: 'Unknown error occurred',
            cause: error,
          );
      }
    }
    return ServerException(
      message: 'Unexpected error occurred',
      cause: error is Exception ? error : null,
    );
  }

  Exception _handleBadResponse(DioException error) {
    final statusCode = error.response?.statusCode ?? 0;
    final responseData = error.response?.data;

    String message = 'Server error';
    if (responseData is Map<String, dynamic> &&
        responseData.containsKey('message')) {
      message = responseData['message'] as String;
    }

    switch (statusCode) {
      case 400:
        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('errors')) {
          final errors = responseData['errors'] as Map<String, dynamic>;
          final fieldErrors = <String, List<String>>{};

          errors.forEach((key, value) {
            if (value is List) {
              fieldErrors[key] = List<String>.from(
                value.map((e) => e.toString()),
              );
            } else {
              fieldErrors[key] = [value.toString()];
            }
          });

          return ValidationException(
            message,
            fieldErrors: fieldErrors,
            cause: error,
          );
        }
        return ServerException(
          message: message,
          statusCode: statusCode,
          cause: error,
        );
      case 401:
        return AuthenticationException('Unauthorized: $message', cause: error);
      case 403:
        return PermissionException('Forbidden: $message', cause: error);
      case 404:
        return NotFoundException('Not found: $message', cause: error);
      default:
        if (statusCode >= 500) {
          return ServerException(
            message: 'Server error: $message',
            statusCode: statusCode,
            cause: error,
          );
        }
        return ServerException(
          message: message,
          statusCode: statusCode,
          cause: error,
        );
    }
  }

  InterceptorsWrapper _createLoggingInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        print('REQUEST[${options.method}] => PATH: ${options.path}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        print(
          'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
        );
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        print(
          'ERROR[${e.response?.statusCode}] => PATH: ${e.requestOptions.path}',
        );
        return handler.next(e);
      },
    );
  }
}
