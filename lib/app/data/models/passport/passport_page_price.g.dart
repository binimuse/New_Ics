// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'passport_page_price.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasePassportPrice _$BasePassportPriceFromJson(Map<String, dynamic> json) =>
    BasePassportPrice(
      id: json['id'] as String,
      passport_type_id: json['passport_type_id'] as String,
      service_urgency_level_id: json['service_urgency_level_id'] as String,
      passport_page_size_id: json['passport_page_size_id'] as String,
      for_abroad: json['for_abroad'] as bool,
      price_etb: (json['price_etb'] as num).toInt(),
      price_usd: (json['price_usd'] as num).toInt(),
      description: json['description'] as String,
      description_json: DescriptionJson.fromJson(
          json['description_json'] as Map<String, dynamic>),
      draft: json['draft'] as bool,
      draftedAt: json['draftedAt'],
      updated_at: json['updated_at'] as String,
    );

Map<String, dynamic> _$BasePassportPriceToJson(BasePassportPrice instance) =>
    <String, dynamic>{
      'id': instance.id,
      'passport_type_id': instance.passport_type_id,
      'service_urgency_level_id': instance.service_urgency_level_id,
      'passport_page_size_id': instance.passport_page_size_id,
      'for_abroad': instance.for_abroad,
      'price_etb': instance.price_etb,
      'price_usd': instance.price_usd,
      'description': instance.description,
      'description_json': instance.description_json,
      'draft': instance.draft,
      'draftedAt': instance.draftedAt,
      'updated_at': instance.updated_at,
    };

DescriptionJson _$DescriptionJsonFromJson(Map<String, dynamic> json) =>
    DescriptionJson(
      en: json['en'] as String?,
      fr: json['fr'] as String?,
    );

Map<String, dynamic> _$DescriptionJsonToJson(DescriptionJson instance) =>
    <String, dynamic>{
      'en': instance.en,
      'fr': instance.fr,
    };
