import 'package:flutter/cupertino.dart';

import 'core_packages.dart';
import 'application.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await runApplication(
    ApiConfig(
      baseUrl: "https://dev",
    ),
  );
}
