// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_embassiy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseEmbassies _$BaseEmbassiesFromJson(Map<String, dynamic> json) =>
    BaseEmbassies(
      id: json['id'] as String,
      name: json['name'] as String,
      name_json: Json.fromJson(json['name_json'] as Map<String, dynamic>),
      description: json['description'] as String,
      description_json:
          Json.fromJson(json['description_json'] as Map<String, dynamic>),
      region_id: json['region_id'] as String,
      daily_new_passport_request_count:
          (json['daily_new_passport_request_count'] as num).toInt(),
      max_appointment_date: json['max_appointment_date'] as String,
      prefix_code: json['prefix_code'] as String,
      has_delivery: json['has_delivery'] as bool,
      delivery_price: (json['delivery_price'] as num).toInt(),
      draft: json['draft'] as bool,
      draftedAt: json['draftedAt'],
      created_at: json['created_at'] as String,
    );

Map<String, dynamic> _$BaseEmbassiesToJson(BaseEmbassies instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'name_json': instance.name_json,
      'description': instance.description,
      'description_json': instance.description_json,
      'region_id': instance.region_id,
      'daily_new_passport_request_count':
          instance.daily_new_passport_request_count,
      'max_appointment_date': instance.max_appointment_date,
      'prefix_code': instance.prefix_code,
      'has_delivery': instance.has_delivery,
      'delivery_price': instance.delivery_price,
      'draft': instance.draft,
      'draftedAt': instance.draftedAt,
      'created_at': instance.created_at,
    };

Json _$JsonFromJson(Map<String, dynamic> json) => Json(
      en: json['en'] as String?,
      fr: json['fr'] as String?,
    );

Map<String, dynamic> _$JsonToJson(Json instance) => <String, dynamic>{
      'en': instance.en,
      'fr': instance.fr,
    };
