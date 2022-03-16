import 'package:flutter_base/domain/domain.dart';
import 'package:json_annotation/json_annotation.dart';

part 'demo_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DemoModel implements DemoEntity {
  @override
  @JsonKey(name: 'name')
  final String name;

  DemoModel(this.name);

  factory DemoModel.fromJson(Map<String, dynamic> json) => _$DemoModelFromJson(json);

  Map<String, dynamic> toJson() => _$DemoModelToJson(this);
}
