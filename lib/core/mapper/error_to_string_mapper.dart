import 'package:flutter/material.dart';
import '../core.dart';

part 'error_mapper_item.dart';

///
class ErrorToStringMapper {
  ErrorToStringMapper._(this._items);

  // Singleton
  static final ErrorToStringMapper instance = ErrorToStringMapper._([
    NoNetworkMapperItem(),
    ApiErrorStringMapperItem(),
    GeneralErrorMapperItem(),
  ]);

  final List<ErrorToStringMapperItem> _items;

  String map(BuildContext context, dynamic error, [List<ErrorToStringMapperItem>? customItems]) {
    final item = _findItem(error, customItems);
    return item.getDisplay(context, error);
  }

  //
  static String parse(BuildContext context, dynamic error,
      [List<ErrorToStringMapperItem>? customItems]) {
    return instance.map(context, error, customItems);
  }

  ///
  ///
  ErrorToStringMapperItem _findItem(dynamic exception, List<ErrorToStringMapperItem>? customItems) {
    if (customItems != null && customItems.isNotEmpty) {
      final index = customItems.indexWhere((element) => element.isMatch(exception));
      if (index >= 0) {
        return customItems[index];
      }
    }

    return _items.firstWhere((element) => element.isMatch(exception));
  }
}
