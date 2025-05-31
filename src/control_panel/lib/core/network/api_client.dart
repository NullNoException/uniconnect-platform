import 'dart:io';

import 'package:control_panel/core/network/api_exception.dart';
import 'package:control_panel/core/constants/app_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  late final Dio _dio;
  final Logger _logger = Logger();
  final SharedPreferences _prefs;
  bool _isRefreshing = false;

  // Base URL from configuration
  final String baseUrl;

  ApiClient({required this.baseUrl, required SharedPreferences prefs})
    : _prefs = prefs {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add interceptors
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Add authentication header if available
          final token = _prefs.getString(PreferenceKeys.authToken);
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          // Log request details in debug mode
          if (kDebugMode) {
            _logger.d('REQUEST[${options.method}] => PATH: ${options.path}');
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          // Log response details in debug mode
          if (kDebugMode) {
            _logger.d(
              'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
            );
          }
          return handler.next(response);
        },
        onError: (DioException e, handler) async {
          // Log error details
          _logger.e(
            'ERROR[${e.response?.statusCode}] => PATH: ${e.requestOptions.path}',
          );

          // Handle authentication errors (401)
          if (e.response?.statusCode == 401 && !_isRefreshing) {
            await _handleTokenRefresh(e, handler);
            return;
          }

          return handler.next(e);
        },
      ),
    );
  }

  // Handle token refresh when 401 error occurs
  Future<void> _handleTokenRefresh(
    DioException error,
    ErrorInterceptorHandler handler,
  ) async {
    final refreshToken = _prefs.getString(PreferenceKeys.refreshToken);

    if (refreshToken == null || _isRefreshing) {
      // No refresh token available or already refreshing, clear auth and continue with error
      await _clearAuthData();
      return handler.next(error);
    }

    _isRefreshing = true;

    try {
      // Attempt to refresh the token
      final response = await _dio.post(
        ApiEndpoints.refreshToken,
        data: {'refreshToken': refreshToken},
        options: Options(headers: {'Authorization': 'Bearer $refreshToken'}),
      );

      if (response.statusCode == 200) {
        final data = response.data;

        // Save new tokens
        await _prefs.setString(PreferenceKeys.authToken, data['token']);
        await _prefs.setString(
          PreferenceKeys.refreshToken,
          data['refreshToken'],
        );
        await _prefs.setString(PreferenceKeys.userId, data['userId']);
        await _prefs.setString(PreferenceKeys.userEmail, data['email']);
        await _prefs.setStringList(
          PreferenceKeys.userRole,
          List<String>.from(data['roles']),
        );
        await _prefs.setString(
          PreferenceKeys.tokenExpiresAt,
          data['expiresAt'],
        );

        // Retry the original request with new token
        final requestOptions = error.requestOptions;
        requestOptions.headers['Authorization'] = 'Bearer ${data['token']}';

        final retryResponse = await _dio.request(
          requestOptions.path,
          options: Options(
            method: requestOptions.method,
            headers: requestOptions.headers,
          ),
          data: requestOptions.data,
          queryParameters: requestOptions.queryParameters,
        );

        return handler.resolve(retryResponse);
      } else {
        // Refresh failed, clear auth data
        await _clearAuthData();
        return handler.next(error);
      }
    } catch (e) {
      // Refresh failed, clear auth data
      await _clearAuthData();
      return handler.next(error);
    } finally {
      _isRefreshing = false;
    }
  }

  // Clear authentication data
  Future<void> _clearAuthData() async {
    await _prefs.remove(PreferenceKeys.authToken);
    await _prefs.remove(PreferenceKeys.refreshToken);
    await _prefs.remove(PreferenceKeys.userId);
    await _prefs.remove(PreferenceKeys.userName);
    await _prefs.remove(PreferenceKeys.userEmail);
    await _prefs.remove(PreferenceKeys.userRole);
    await _prefs.remove(PreferenceKeys.tokenExpiresAt);
  }

  // GET request method
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      throw _handleError(e);
    }
  }

  // POST request method
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      throw _handleError(e);
    }
  }

  // PUT request method
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      throw _handleError(e);
    }
  }

  // DELETE request method
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } catch (e) {
      throw _handleError(e);
    }
  }

  // PATCH request method
  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.patch<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Method to upload files
  Future<Response<T>> uploadFile<T>(
    String path,
    File file, {
    Map<String, dynamic>? data,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
  }) async {
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        ...?data,
        'file': await MultipartFile.fromFile(file.path, filename: fileName),
      });

      final response = await _dio.post<T>(
        path,
        data: formData,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        options: Options(headers: {'Content-Type': 'multipart/form-data'}),
      );
      return response;
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Error handling helper
  Exception _handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return TimeoutException('Connection timeout');
        case DioExceptionType.sendTimeout:
          return TimeoutException('Send timeout');
        case DioExceptionType.receiveTimeout:
          return TimeoutException('Receive timeout');
        case DioExceptionType.badCertificate:
          return CertificateException('Bad certificate');
        case DioExceptionType.badResponse:
          return ApiException(
            statusCode: error.response?.statusCode ?? 500,
            message: error.response?.data?['message'] ?? 'Bad response',
          );
        case DioExceptionType.cancel:
          return CancelException('Request cancelled');
        case DioExceptionType.connectionError:
          return ConnectionException('Connection error');
        case DioExceptionType.unknown:
          return UnknownException(error.message ?? 'Unknown error');
      }
    }
    return UnknownException('Unknown error occurred');
  }
}

// Custom exceptions
// class ApiException implements Exception {
//   final String message;
//   final int? statusCode;

//   ApiException({required this.message, this.statusCode});

//   factory ApiException.fromDioError(DioException error) {
//     String message;
//     int? statusCode;

//     switch (error.type) {
//       case DioExceptionType.connectionTimeout:
//       case DioExceptionType.sendTimeout:
//       case DioExceptionType.receiveTimeout:
//         message = 'Connection timeout';
//         break;
//       case DioExceptionType.badResponse:
//         message = error.response?.statusMessage ?? 'Server error';
//         statusCode = error.response?.statusCode;
//         break;
//       case DioExceptionType.cancel:
//         message = 'Request cancelled';
//         break;
//       default:
//         message = 'Network error occurred: ${error.message}';
//     }

//     return ApiException(message: message, statusCode: statusCode);
//   }
// }

class TimeoutException implements Exception {
  final String message;

  TimeoutException(this.message);

  @override
  String toString() => 'TimeoutException: $message';
}

class ConnectionException implements Exception {
  final String message;

  ConnectionException(this.message);

  @override
  String toString() => 'ConnectionException: $message';
}

class CertificateException implements Exception {
  final String message;

  CertificateException(this.message);

  @override
  String toString() => 'CertificateException: $message';
}

class CancelException implements Exception {
  final String message;

  CancelException(this.message);

  @override
  String toString() => 'CancelException: $message';
}

class UnknownException implements Exception {
  final String message;

  UnknownException(this.message);

  @override
  String toString() => 'UnknownException: $message';
}
