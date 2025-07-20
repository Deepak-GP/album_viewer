import 'package:dio/dio.dart';

import '../constants/app_constants.dart';
import '../errors/failures.dart';

abstract class NetworkService {
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters});
}

class NetworkServiceImpl implements NetworkService {
  final Dio _dio;

  NetworkServiceImpl() : _dio = Dio() {
    _dio.options.baseUrl = AppConstants.baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);

    // Add interceptors for logging and error handling
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
  }

  @override
  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          throw const NetworkFailure('Connection timeout');
        case DioExceptionType.badResponse:
          throw ServerFailure('Server error: ${e.response?.statusCode}');
        case DioExceptionType.cancel:
          throw const NetworkFailure('Request cancelled');
        default:
          throw const NetworkFailure('Network error occurred');
      }
    } catch (e) {
      throw NetworkFailure('Unexpected error: $e');
    }
  }
}
