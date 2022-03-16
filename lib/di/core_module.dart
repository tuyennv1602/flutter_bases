import 'package:get_it/get_it.dart';

import '../core_packages.dart';

///
Future<void> coreModule(GetIt getIt) async {
  getIt.registerLazySingleton<ThemeModel>(() => ThemeModel());
}
