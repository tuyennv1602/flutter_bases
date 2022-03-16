import 'package:dio/dio.dart';

import '../../../data/data.dart';

class AuthInterceptor extends Interceptor {
  final TokenProvider _tokenProvider;
  AuthInterceptor(this._tokenProvider);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String? apiToken = _tokenProvider.token;
    Map<String, String> headers = Map.from(options.headers);
    if (apiToken != null && apiToken.isNotEmpty) {
      headers["Authorization"] = 'Bearer $apiToken';
    }
    options.headers = headers;

    return super.onRequest(options, handler);
  }
}
