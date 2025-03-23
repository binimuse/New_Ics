// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'base_embassiy.g.dart';

@JsonSerializable()
class BaseEmbassies {
  const BaseEmbassies({
    required this.id,
    required this.name,
    required this.name_json,
    required this.description,
    required this.description_json,
    required this.region_id,
    required this.daily_new_passport_request_count,
    required this.max_appointment_date,
    required this.prefix_code,
    required this.has_delivery,
    required this.delivery_price,
    required this.draft,
    required this.draftedAt,

    required this.created_at,
  });

  factory BaseEmbassies.fromJson(Map<String, dynamic> json) =>
      _$BaseEmbassiesFromJson(json);

  final String id;
  final String name;
  final Json name_json;
  final String description;
  final Json description_json;
  final String region_id;
  final int daily_new_passport_request_count;
  final String max_appointment_date;
  final String prefix_code;
  final bool has_delivery;
  final int delivery_price;
  final bool draft;
  final dynamic draftedAt;

  final String created_at;

  Map<String, dynamic> toJson() => _$BaseEmbassiesToJson(this);
}

@JsonSerializable()
class Json {
  const Json({this.en, this.fr});

  factory Json.fromJson(Map<String, dynamic> json) => _$JsonFromJson(json);

  final String? en;
  final String? fr;

  Map<String, dynamic> toJson() => _$JsonToJson(this);
}
