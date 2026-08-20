import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tayf/core/exceptions/app_exceptions.dart';

class DioHelper {
  static Dio? _dio;
  static int _retryCount = 0;
  static const int _maxRetries = 3;

  static Dio get dio {
    _dio ??= _createDio();
    return _dio!;
  }

  static Dio _createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: '', // Set your base URL here
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        receiveDataWhenStatusError: true,
        followRedirects: true,
        validateStatus: (status) {
          // Don't throw on 5xx, let the API methods handle it
          return status != null && status < 500;
        },
      ),
    );

    // Add logger interceptor
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
        compact: false,
        maxWidth: 120,
      ),
    );

    // Add retry interceptor (only handles network retries, not business logic)
    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException error, ErrorInterceptorHandler handler) async {
          if (!_shouldRetry(error)) {
            return handler.next(error);
          }

          if (_retryCount >= _maxRetries) {
            _retryCount = 0;
            return handler.next(error);
          }

          _retryCount++;
          log(
            'Retrying request ($_retryCount/$_maxRetries): ${error.requestOptions.path}',
          );

          // Exponential backoff: 1s, 2s, 4s
          final delay = Duration(seconds: 1 << (_retryCount - 1));
          await Future.delayed(delay);

          try {
            final response = await _retryRequest(error.requestOptions);
            _retryCount = 0;
            return handler.resolve(response);
          } on DioException catch (e) {
            return handler.next(e);
          }
        },
      ),
    );

    return dio;
  }

  static bool _shouldRetry(DioException error) {
    // Retry on network errors and timeouts, but not on client errors (4xx)
    return error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.connectionError ||
        (error.type == DioExceptionType.badResponse &&
            error.response?.statusCode != null &&
            error.response!.statusCode! >= 500);
  }

  static Future<Response> _retryRequest(RequestOptions options) async {
    return _dio!.fetch(options);
  }

  /// Maps DioException to our custom AppException
  static AppException _mapDioErrorToAppException(DioException error) {
    if (error.type == DioExceptionType.badResponse && error.response != null) {
      return ServerException.fromDioError(error);
    }
    return NetworkException.fromDioError(error);
  }

  /// GET request
  static Future<Response> getData({
    required String endPoints,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    bool withRetry = true,
  }) async {
    _retryCount = 0;
    try {
      final response = await dio.get(
        endPoints,
        queryParameters: query,
        options: Options(headers: headers, followRedirects: true),
      );
      return _checkResponse(response);
    } on AppException {
      rethrow;
    } on DioException catch (e) {
      throw _mapDioErrorToAppException(e);
    } catch (e, stackTrace) {
      throw UnknownException.fromError(e, stackTrace);
    }
  }

  /// POST request
  static Future<Response> postRequest({
    required String endPoints,
    Map<String, dynamic>? headers,
    required Map<String, dynamic> data,
    bool withRetry = false, // POST requests usually shouldn't auto-retry
  }) async {
    _retryCount = 0;
    try {
      final response = await dio.post(
        endPoints,
        data: data,
        options: Options(headers: headers),
      );
      return _checkResponse(response);
    } on AppException {
      rethrow;
    } on DioException catch (e) {
      throw _mapDioErrorToAppException(e);
    } catch (e, stackTrace) {
      throw UnknownException.fromError(e, stackTrace);
    }
  }

  /// PUT request
  static Future<Response> putRequest({
    required String endPoints,
    Map<String, dynamic>? headers,
    required Map<String, dynamic> data,
    bool withRetry = false,
  }) async {
    _retryCount = 0;
    try {
      final response = await dio.put(
        endPoints,
        data: data,
        options: Options(headers: headers),
      );
      return _checkResponse(response);
    } on AppException {
      rethrow;
    } on DioException catch (e) {
      throw _mapDioErrorToAppException(e);
    } catch (e, stackTrace) {
      throw UnknownException.fromError(e, stackTrace);
    }
  }

  /// PATCH request
  static Future<Response> patchRequest({
    required String endPoints,
    Map<String, dynamic>? headers,
    required Map<String, dynamic> data,
  }) async {
    _retryCount = 0;
    try {
      final response = await dio.patch(
        endPoints,
        data: data,
        options: Options(headers: headers),
      );
      return _checkResponse(response);
    } on AppException {
      rethrow;
    } on DioException catch (e) {
      throw _mapDioErrorToAppException(e);
    } catch (e, stackTrace) {
      throw UnknownException.fromError(e, stackTrace);
    }
  }

  /// DELETE request
  static Future<Response> deleteRequest({
    required String endPoints,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
  }) async {
    _retryCount = 0;
    try {
      final response = await dio.delete(
        endPoints,
        data: data,
        queryParameters: query,
        options: Options(headers: headers),
      );
      return _checkResponse(response);
    } on AppException {
      rethrow;
    } on DioException catch (e) {
      throw _mapDioErrorToAppException(e);
    } catch (e, stackTrace) {
      throw UnknownException.fromError(e, stackTrace);
    }
  }

  /// Upload file with progress
  static Future<Response> uploadFile({
    required String endPoints,
    required String filePath,
    String? fileName,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    ProgressCallback? onSendProgress,
  }) async {
    _retryCount = 0;
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath, filename: fileName),
        ...?data,
      });

      final response = await dio.post(
        endPoints,
        data: formData,
        options: Options(headers: headers),
        onSendProgress: onSendProgress,
      );
      return _checkResponse(response);
    } on AppException {
      rethrow;
    } on DioException catch (e) {
      throw _mapDioErrorToAppException(e);
    } catch (e, stackTrace) {
      throw UnknownException.fromError(e, stackTrace);
    }
  }

  /// Download file with progress
  static Future<Response> downloadFile({
    required String endPoints,
    required String savePath,
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await dio.download(
        endPoints,
        savePath,
        queryParameters: query,
        options: Options(headers: headers),
        onReceiveProgress: onReceiveProgress,
      );
      return _checkResponse(response);
    } on AppException {
      rethrow;
    } on DioException catch (e) {
      throw _mapDioErrorToAppException(e);
    } catch (e, stackTrace) {
      throw UnknownException.fromError(e, stackTrace);
    }
  }

  /// Check response status and throw if error (4xx, 5xx)
  static Response _checkResponse(Response response) {
    if (response.statusCode != null && response.statusCode! >= 400) {
      throw ServerException.fromDioError(
        DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          error: 'HTTP ${response.statusCode}',
        ),
      );
    }
    return response;
  }

  /// Set auth token for subsequent requests
  static void setAuthToken(String token) {
    dio.options.headers['Authorization'] = 'Bearer $token';
  }

  /// Clear auth token
  static void clearAuthToken() {
    dio.options.headers.remove('Authorization');
  }

  /// Set base URL
  static void setBaseUrl(String baseUrl) {
    dio.options.baseUrl = baseUrl;
  }

  /// Add custom header
  static void addHeader(String key, String value) {
    dio.options.headers[key] = value;
  }

  /// Remove custom header
  static void removeHeader(String key) {
    dio.options.headers.remove(key);
  }

  /// Initialize Dio with custom config
  static void init({
    String baseUrl = '',
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    Map<String, dynamic>? defaultHeaders,
  }) {
    _dio = _createDio()
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = connectTimeout ?? const Duration(seconds: 30)
      ..options.receiveTimeout = receiveTimeout ?? const Duration(seconds: 30)
      ..options.sendTimeout = sendTimeout ?? const Duration(seconds: 30);

    if (defaultHeaders != null) {
      _dio!.options.headers.addAll(defaultHeaders);
    }
  }
}
