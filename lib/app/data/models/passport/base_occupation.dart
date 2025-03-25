// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'base_occupation.g.dart';

@JsonSerializable()
class BaseOccupation {
  const BaseOccupation({
    required this.id,
    required this.name,
    required this.name_json,
    required this.description,
    required this.description_json,
    required this.draft,

    required this.updated_at,
  });

  factory BaseOccupation.fromJson(Map<String, dynamic> json) =>
      _$BaseOccupationFromJson(json);

  final String id;
  final String name;
  final Json name_json;
  final String description;
  final Json description_json;
  final bool draft;

  final String updated_at;

  Map<String, dynamic> toJson() => _$BaseOccupationToJson(this);
}

@JsonSerializable()
class Json {
  const Json({this.en, this.fr});

  factory Json.fromJson(Map<String, dynamic> json) => _$JsonFromJson(json);

  final String? en;
  final String? fr;

  Map<String, dynamic> toJson() => _$JsonToJson(this);
}
