import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

///
Future<void> localModule(GetIt getIt) async {
  final sharedPreferences = await SharedPreferences.getInstance();
}
