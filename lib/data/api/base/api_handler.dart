import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../exceptions/exceptions.dart';

typedef ApiResponseToModelParser<T> = T Function(Map<String, dynamic> json);

///
abstract class ApiHandler {
  factory ApiHandler(Dio dio) => _ApiHandlerImpl(dio);

  Future<T> post<T>(
    String path, {
    required ApiResponseToModelParser<T> parser,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Options? options,
  });

  Future<T> get<T>(
    String path, {
    required ApiResponseToModelParser<T> parser,
    Map<String, dynamic>? queryParameters,
    Options? options,
  });

  Future<List<T>> getList<T>(
    String path, {
    required ApiResponseToModelParser<T> parser,
    Map<String, dynamic>? queryParameters,
    Options? options,
  });

  Future<T> put<T>(
    String path, {
    required ApiResponseToModelParser<T> parser,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Options? options,
  });

  Future<T> delete<T>(
    String path, {
    required ApiResponseToModelParser<T> parser,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Options? options,
  });
}

class _ApiHandlerImpl implements ApiHandler {
  _ApiHandlerImpl(this._dio);

  final Dio _dio;

  @override
  Future<T> post<T>(
    String path, {
    required ApiResponseToModelParser<T> parser,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _remapError(() async {
      final response = await _dio.post(
        path,
        data: body,
        queryParameters: queryParameters,
        options: options,
      );
      return parser(response.data);
    });
  }

  @override
  Future<T> get<T>(
    String path, {
    required ApiResponseToModelParser<T> parser,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _remapError(() async {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      return parser(response.data);
    });
  }

  @override
  Future<T> delete<T>(
    String path, {
    required ApiResponseToModelParser<T> parser,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _remapError(() async {
      final response = await _dio.delete(
        path,
        data: body,
        queryParameters: queryParameters,
        options: options,
      );
      return parser(response.data);
    });
  }

  @override
  Future<T> put<T>(
    String path, {
    required ApiResponseToModelParser<T> parser,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _remapError(() async {
      final response = await _dio.put(
        path,
        data: body,
        queryParameters: queryParameters,
        options: options,
      );
      return parser(response.data);
    });
  }

  @override
  Future<List<T>> getList<T>(
    String path, {
    required ApiResponseToModelParser<T> parser,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _remapError(() async {
      final response = await _dio.get(path, queryParameters: queryParameters, options: options);
      if (response.data is List) {
        return (response.data as List).map<T>((e) => parser(e as Map<String, dynamic>)).toList();
      } else {
        throw '${response.data?.runtimeType} is not a List<Map<String, dynamic>';
      }
    });
  }

  Future<T> _remapError<T>(ValueGetter<Future<T>> func) async {
    try {
      return await func();
    } catch (e) {
      throw (await _apiErrorToInternalError(e));
    }
  }

  Future<dynamic> _apiErrorToInternalError(e) async {
    if (e is DioError) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.error is SocketException) {
        return NetworkIssueException();
      }

      final responseData = e.response?.data;
      if (responseData != null && responseData is String) {
        return ApiErrorException(responseData, e.response?.statusCode);
      } else if (responseData != null && responseData is Map) {
        final error = responseData["Message"];
        if (error != null && error is String) {
          return ApiErrorException(error, e.response?.statusCode);
        }
      }

      return HttpCallException(e.message);
    }
    return e;
  }
}
