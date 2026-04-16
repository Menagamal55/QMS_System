// lib/core/network/dio_client.dart

import 'package:dio/dio.dart';
import 'package:sw2project/core/base_usecase/Api%20constants.dart';
import 'package:sw2project/core/base_usecase/Exceptions%20.dart';

class DioClient {
  late final Dio _dio;

  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(milliseconds: ApiConstants.connectTimeout),
        receiveTimeout: const Duration(milliseconds: ApiConstants.receiveTimeout),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.addAll([
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (object) => print(object),
      ),
      InterceptorsWrapper(
        onError: (DioException e, handler) {
          handler.next(e);
        },
      ),
    ]);
  }

  Future<Response> post(
    String path, {
    Map<String, dynamic>? data,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        options: Options(headers: headers),
      );
      return response;
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  Future<Response> get(
    String path, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response;
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  void _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        throw NetworkException(message: 'Connection timeout. Please try again.');
      case DioExceptionType.connectionError:
        throw NetworkException(
            message: 'No internet connection. Please check your network.');
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final message = e.response?.data['message'] ??
            e.response?.data['Message'] ??
            'Server error occurred.';
        if (statusCode == 401) {
          throw UnauthorizedException(message: message.toString());
        }
        throw ServerException(
          message: message.toString(),
          statusCode: statusCode,
        );
      default:
        throw ServerException(message: 'An unexpected error occurred.');
    }
  }
}