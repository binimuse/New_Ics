// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'passport_page_price.g.dart';

@JsonSerializable()
class BasePassportPrice {
  const BasePassportPrice({
    required this.id,
    required this.passport_type_id,
    required this.service_urgency_level_id,
    required this.passport_page_size_id,
    required this.for_abroad,
    required this.price_etb,
    required this.price_usd,
    required this.description,
    required this.description_json,
    required this.draft,
    required this.draftedAt,

    required this.updated_at,
  });

  factory BasePassportPrice.fromJson(Map<String, dynamic> json) =>
      _$BasePassportPriceFromJson(json);
  final String id;
  final String passport_type_id;
  final String service_urgency_level_id;
  final String passport_page_size_id;
  final bool for_abroad;
  final int price_etb;
  final int price_usd;
  final String description;
  final DescriptionJson description_json;
  final bool draft;
  final dynamic draftedAt;

  final String updated_at;

  Map<String, dynamic> toJson() => _$BasePassportPriceToJson(this);
}

@JsonSerializable()
class DescriptionJson {
  const DescriptionJson({this.en, this.fr});

  factory DescriptionJson.fromJson(Map<String, dynamic> json) =>
      _$DescriptionJsonFromJson(json);

  final String? en;
  final String? fr;

  Map<String, dynamic> toJson() => _$DescriptionJsonToJson(this);
}
