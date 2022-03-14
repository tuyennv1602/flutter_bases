import 'package:flutter/cupertino.dart';

import 'data/api/base/api_config.dart';
import 'main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await runApplication(
    ApiConfig(
      baseUrl: "https://uat",
    ),
  );
}
