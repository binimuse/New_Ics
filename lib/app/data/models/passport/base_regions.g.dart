// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_regions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseRegionResponce _$BaseRegionResponceFromJson(Map<String, dynamic> json) =>
    BaseRegionResponce(
      id: json['id'] as String?,
      name: json['name'] as String?,
      nameJson: json['nameJson'] == null
          ? null
          : Json.fromJson(json['nameJson'] as Map<String, dynamic>),
      description: json['description'] as String?,
      description_json: json['description_json'] == null
          ? null
          : Json.fromJson(json['description_json'] as Map<String, dynamic>),
      draft: json['draft'] as bool?,
      drafted_at: json['drafted_at'],
      country_id: json['country_id'] as String,
      zip_code: json['zip_code'] as String,
      created_at: json['created_at'] as String?,
      updated_at: json['updated_at'] as String?,
    );

Map<String, dynamic> _$BaseRegionResponceToJson(BaseRegionResponce instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'nameJson': instance.nameJson,
      'description': instance.description,
      'description_json': instance.description_json,
      'draft': instance.draft,
      'drafted_at': instance.drafted_at,
      'country_id': instance.country_id,
      'zip_code': instance.zip_code,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };

Json _$JsonFromJson(Map<String, dynamic> json) => Json(
      en: json['en'] as String?,
      fr: json['fr'] as String?,
    );

Map<String, dynamic> _$JsonToJson(Json instance) => <String, dynamic>{
      'en': instance.en,
      'fr': instance.fr,
    };
