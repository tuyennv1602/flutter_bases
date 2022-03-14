import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../data/data.dart';

Dio _buildDio(ApiConfig config, List<Interceptor> interceptors) {
  return Dio()
    ..options.baseUrl = config.baseUrl
    ..interceptors.addAll(interceptors);
}

///
Future<void> networkModule(GetIt getIt, ApiConfig config) async {
  ///
  getIt.registerLazySingleton<AuthInterceptor>(() => AuthInterceptor(getIt()));
  getIt.registerLazySingleton<Dio>(() => _buildDio(
        config,
        [
          getIt<AuthInterceptor>(),
          logInterceptor,
        ],
      ));
  getIt.registerLazySingleton<ApiHandler>(() => ApiHandler(getIt()));
}
