// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseCountry _$BaseCountryFromJson(Map<String, dynamic> json) => BaseCountry(
      id: json['id'] as String,
      name: json['name'] as String,
      country_code: json['country_code'] as String,
      nationality: json['nationality'] as String,
      flag: json['flag'],
      description: json['description'] as String,
      accept_visa: json['accept_visa'] as bool,
      accept_passport: json['accept_passport'] as bool,
      accept_origin_id: json['accept_origin_id'] as bool,
      accept_residency_id: json['accept_residency_id'] as bool,
      accept_travel_document: json['accept_travel_document'] as bool,
      draft: json['draft'] as bool,
    );

Map<String, dynamic> _$BaseCountryToJson(BaseCountry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'country_code': instance.country_code,
      'nationality': instance.nationality,
      'flag': instance.flag,
      'description': instance.description,
      'accept_visa': instance.accept_visa,
      'accept_passport': instance.accept_passport,
      'accept_origin_id': instance.accept_origin_id,
      'accept_residency_id': instance.accept_residency_id,
      'accept_travel_document': instance.accept_travel_document,
      'draft': instance.draft,
    };

Json _$JsonFromJson(Map<String, dynamic> json) => Json(
      en: json['en'] as String?,
      fr: json['fr'] as String?,
    );

Map<String, dynamic> _$JsonToJson(Json instance) => <String, dynamic>{
      'en': instance.en,
      'fr': instance.fr,
    };
