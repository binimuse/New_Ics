// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'base_regions.g.dart';

@JsonSerializable()
class BaseRegionResponce {
  const BaseRegionResponce({
    this.id,
    this.name,
    this.nameJson,
    this.description,
    this.description_json,
    this.draft,
    this.drafted_at,
    required this.country_id,
    required this.zip_code,
    this.created_at,
    this.updated_at,
  });

  factory BaseRegionResponce.fromJson(Map<String, dynamic> json) =>
      _$BaseRegionResponceFromJson(json);

  final String? id;
  final String? name;
  final Json? nameJson;
  final String? description;
  final Json? description_json;
  final bool? draft;
  final dynamic drafted_at;
  final String country_id;
  final String zip_code;
  final String? created_at;
  final String? updated_at;

  Map<String, dynamic> toJson() => _$BaseRegionResponceToJson(this);
}

@JsonSerializable()
class Json {
  const Json({this.en, this.fr});

  factory Json.fromJson(Map<String, dynamic> json) => _$JsonFromJson(json);

  final String? en;
  final String? fr;

  Map<String, dynamic> toJson() => _$JsonToJson(this);
}
