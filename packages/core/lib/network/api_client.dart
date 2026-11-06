import 'package:dio/dio.dart';
import '../error/failures.dart';
import 'api_endpoints.dart';

class ApiClient {
  final Dio dio;

  ApiClient({Dio? customDio, String? baseUrl})
      : dio = customDio ??
            Dio(
              BaseOptions(
                baseUrl: baseUrl ?? ApiEndpoints.defaultBaseUrl,
                connectTimeout: const Duration(seconds: 10),
                receiveTimeout: const Duration(seconds: 10),
                headers: {
                  'Content-Type': 'application/json',
                  'Accept': 'application/json',
                },
              ),
            );

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Failure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return const NetworkFailure();
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        if (statusCode == 401 || statusCode == 403) {
          return const UnauthorizedFailure();
        }
        final message = error.response?.data is Map &&
                error.response?.data['error'] != null
            ? error.response?.data['error']['message'] ?? 'Server error'
            : 'Server error ($statusCode)';
        return ServerFailure(message: message.toString(), code: statusCode.toString());
      default:
        return ServerFailure(
          message: error.message ?? 'Unexpected network exception occurred',
        );
    }
  }
}
