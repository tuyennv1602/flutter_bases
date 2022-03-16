import 'package:flutter_base/data/data.dart';

import '../../domain/repositories/repositories.dart';

class DemoRepositoryImpl implements DemoRepository {
  final TokenProvider tokenProvider;

  DemoRepositoryImpl(this.tokenProvider);
}
