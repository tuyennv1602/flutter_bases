import 'package:dio/dio.dart';

final logInterceptor = LogInterceptor(
  requestBody: true,
  responseBody: true,
);
