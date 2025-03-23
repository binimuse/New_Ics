// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'base_country.g.dart';

@JsonSerializable()
class BaseCountry {
  const BaseCountry({
    required this.id,
    required this.name,
    required this.country_code,
    required this.nationality,
    required this.flag,
    required this.description,
    required this.accept_visa,
    required this.accept_passport,
    required this.accept_origin_id,
    required this.accept_residency_id,
    required this.accept_travel_document,
    required this.draft,
  });

  factory BaseCountry.fromJson(Map<String, dynamic> json) =>
      _$BaseCountryFromJson(json);

  final String id;
  final String name;
  final String country_code;
  final String nationality;
  final dynamic flag;
  final String description;
  final bool accept_visa;
  final bool accept_passport;
  final bool accept_origin_id;
  final bool accept_residency_id;
  final bool accept_travel_document;
  final bool draft;

  Map<String, dynamic> toJson() => _$BaseCountryToJson(this);
}

@JsonSerializable()
class Json {
  const Json({this.en, this.fr});

  factory Json.fromJson(Map<String, dynamic> json) => _$JsonFromJson(json);

  final String? en;
  final String? fr;

  Map<String, dynamic> toJson() => _$JsonToJson(this);
}
