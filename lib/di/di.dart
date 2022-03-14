import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/data.dart';
import 'bloc_module.dart';
import 'core_module.dart';
import 'local_module.dart';
import 'network_module.dart';
import 'repository_module.dart';

///
/// Setup Di
///
Future<void> setupDi(ApiConfig config) async {
  final getIt = GetIt.I;
  await coreModule(getIt);
  await localModule(getIt);
  await networkModule(getIt, config);
  await repositoryModule(getIt);
  await blocModule(getIt);
  GetIt.instance.registerSingleton(await SharedPreferences.getInstance());
}
