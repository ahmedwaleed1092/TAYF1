import 'package:dio/dio.dart';

/// Base exception class for the application
abstract class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;
  final StackTrace? stackTrace;

  const AppException({
    required this.message,
    this.code,
    this.originalError,
    this.stackTrace,
  });

  @override
  String toString() =>
      'AppException: $message${code != null ? ' (Code: $code)' : ''}';
}

/// Network-related exceptions (no internet, timeout, etc.)
class NetworkException extends AppException {
  const NetworkException({
    required String message,
    String? code,
    dynamic originalError,
    StackTrace? stackTrace,
  }) : super(
         message: message,
         code: code ?? 'NETWORK_ERROR',
         originalError: originalError,
         stackTrace: stackTrace,
       );

  factory NetworkException.fromDioError(DioException e) {
    String message;
    String code;

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        message =
            'Connection timed out. Please check your internet and try again.';
        code = 'TIMEOUT';
        break;
      case DioExceptionType.connectionError:
        if (e.message?.contains('SocketException') == true) {
          message =
              'No internet connection. Please check your connection and try again.';
          code = 'NO_INTERNET';
        } else {
          message = 'Failed to connect to server. Please try again later.';
          code = 'CONNECTION_ERROR';
        }
        break;
      case DioExceptionType.cancel:
        message = 'Request was cancelled.';
        code = 'CANCELLED';
        break;
      case DioExceptionType.badResponse:
        // This shouldn't happen here as it's handled by ServerException
        message = 'Server error. Please try again.';
        code = 'SERVER_ERROR';
        break;
      case DioExceptionType.badCertificate:
        message = 'Security certificate error. Please contact support.';
        code = 'BAD_CERTIFICATE';
        break;
      case DioExceptionType.unknown:
      default:
        message =
            'Network error occurred. Please check your connection and try again.';
        code = 'UNKNOWN_NETWORK_ERROR';
        break;
    }

    return NetworkException(
      message: message,
      code: code,
      originalError: e,
      stackTrace: e.stackTrace,
    );
  }
}

/// Server-side exceptions (4xx, 5xx errors)
class ServerException extends AppException {
  final int? statusCode;
  final Map<String, dynamic>? responseData;

  const ServerException({
    required String message,
    this.statusCode,
    this.responseData,
    String? code,
    dynamic originalError,
    StackTrace? stackTrace,
  }) : super(
         message: message,
         code: code ?? 'SERVER_ERROR',
         originalError: originalError,
         stackTrace: stackTrace,
       );

  factory ServerException.fromDioError(DioException e) {
    final statusCode = e.response?.statusCode;
    final responseData = e.response?.data as Map<String, dynamic>?;

    String message;
    String code;

    if (statusCode == null) {
      message = 'Server error. Please try again.';
      code = 'SERVER_ERROR';
    } else if (statusCode >= 500) {
      message = 'Server is currently unavailable. Please try again later.';
      code = 'SERVER_UNAVAILABLE';
    } else if (statusCode == 401) {
      message = 'Your session has expired. Please log in again.';
      code = 'UNAUTHORIZED';
    } else if (statusCode == 403) {
      message = 'You don\'t have permission to perform this action.';
      code = 'FORBIDDEN';
    } else if (statusCode == 404) {
      message = 'The requested resource was not found.';
      code = 'NOT_FOUND';
    } else if (statusCode == 422) {
      message =
          responseData?['message'] ??
          'Validation failed. Please check your input.';
      code = 'VALIDATION_ERROR';
    } else if (statusCode == 429) {
      message = 'Too many requests. Please wait a moment and try again.';
      code = 'RATE_LIMITED';
    } else if (statusCode! >= 400) {
      message = responseData?['message'] ?? 'Request failed. Please try again.';
      code = 'CLIENT_ERROR';
    } else {
      message = 'Request failed. Please try again.';
      code = 'UNKNOWN_ERROR';
    }

    return ServerException(
      message: message,
      statusCode: statusCode,
      responseData: responseData,
      code: code,
      originalError: e,
      stackTrace: e.stackTrace,
    );
  }
}

/// Local storage/cache exceptions
class CacheException extends AppException {
  const CacheException({
    required String message,
    String? code,
    dynamic originalError,
    StackTrace? stackTrace,
  }) : super(
         message: message,
         code: code ?? 'CACHE_ERROR',
         originalError: originalError,
         stackTrace: stackTrace,
       );
}

/// Authentication/Authorization exceptions
class AuthException extends AppException {
  const AuthException({
    required String message,
    String? code,
    dynamic originalError,
    StackTrace? stackTrace,
  }) : super(
         message: message,
         code: code ?? 'AUTH_ERROR',
         originalError: originalError,
         stackTrace: stackTrace,
       );
}

/// Validation exceptions from user input
class ValidationException extends AppException {
  final Map<String, String>? fieldErrors;

  const ValidationException({
    required String message,
    this.fieldErrors,
    String? code,
    dynamic originalError,
    StackTrace? stackTrace,
  }) : super(
         message: message,
         code: code ?? 'VALIDATION_ERROR',
         originalError: originalError,
         stackTrace: stackTrace,
       );
}

/// Unknown/unexpected exceptions
class UnknownException extends AppException {
  const UnknownException({
    required String message,
    String? code,
    dynamic originalError,
    StackTrace? stackTrace,
  }) : super(
         message: message,
         code: code ?? 'UNKNOWN_ERROR',
         originalError: originalError,
         stackTrace: stackTrace,
       );

  factory UnknownException.fromError(dynamic error, [StackTrace? stackTrace]) {
    return UnknownException(
      message: 'An unexpected error occurred: ${error.toString()}',
      originalError: error,
      stackTrace: stackTrace,
    );
  }
}
