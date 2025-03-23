// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'passport_page_size.g.dart';

@JsonSerializable()
class BasePassportPageSize {
  const BasePassportPageSize({
    this.id,
    this.name,
    this.nameJson,
    this.description,
    this.description_json,
    this.draft,
    this.drafted_at,
    required this.page_size,
    this.created_at,
    this.updated_at,
  });

  factory BasePassportPageSize.fromJson(Map<String, dynamic> json) =>
      _$BasePassportPageSizeFromJson(json);

  final String? id;
  final String? name;
  final Json? nameJson;
  final String? description;
  final Json? description_json;
  final bool? draft;
  final dynamic drafted_at;
  final int page_size;
  final String? created_at;
  final String? updated_at;

  Map<String, dynamic> toJson() => _$BasePassportPageSizeToJson(this);
}

@JsonSerializable()
class Json {
  const Json({this.en, this.fr});

  factory Json.fromJson(Map<String, dynamic> json) => _$JsonFromJson(json);

  final String? en;
  final String? fr;

  Map<String, dynamic> toJson() => _$JsonToJson(this);
}
