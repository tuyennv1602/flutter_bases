import 'package:json_annotation/json_annotation.dart';

class AnyToStringConverter implements JsonConverter<String, dynamic> {
  const AnyToStringConverter();

  @override
  String fromJson(json) {
    return json.toString();
  }

  @override
  toJson(String object) {
    return object;
  }
}
