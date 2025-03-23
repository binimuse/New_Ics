// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'passport_urgency_type.g.dart';

@JsonSerializable()
class BasePassportUrgencyType {
  const BasePassportUrgencyType({
    this.id,
    this.name,
    this.nameJson,
    this.description,
    this.description_json,
    this.draft,
    this.drafted_at,
    required this.priority,
    required this.for_abroad,
    required this.processing_days_count,
    this.created_at,
    this.updated_at,
  });

  factory BasePassportUrgencyType.fromJson(Map<String, dynamic> json) =>
      _$BasePassportUrgencyTypeFromJson(json);

  final String? id;
  final String? name;
  final Json? nameJson;
  final String? description;
  final Json? description_json;
  final bool? draft;
  final bool for_abroad;
  final dynamic drafted_at;
  final int priority;
  final int processing_days_count;
  final String? created_at;
  final String? updated_at;

  Map<String, dynamic> toJson() => _$BasePassportUrgencyTypeToJson(this);
}

@JsonSerializable()
class Json {
  const Json({this.en, this.fr});

  factory Json.fromJson(Map<String, dynamic> json) => _$JsonFromJson(json);

  final String? en;
  final String? fr;

  Map<String, dynamic> toJson() => _$JsonToJson(this);
}
