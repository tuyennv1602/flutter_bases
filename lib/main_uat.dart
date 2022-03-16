import 'package:flutter/cupertino.dart';

import 'application.dart';
import 'core/core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await runApplication(
    ApiConfig(
      baseUrl: "https://uat",
    ),
  );
}
