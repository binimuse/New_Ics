// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_occupation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseOccupation _$BaseOccupationFromJson(Map<String, dynamic> json) =>
    BaseOccupation(
      id: json['id'] as String,
      name: json['name'] as String,
      name_json: Json.fromJson(json['name_json'] as Map<String, dynamic>),
      description: json['description'] as String,
      description_json:
          Json.fromJson(json['description_json'] as Map<String, dynamic>),
      draft: json['draft'] as bool,
      updated_at: json['updated_at'] as String,
    );

Map<String, dynamic> _$BaseOccupationToJson(BaseOccupation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'name_json': instance.name_json,
      'description': instance.description,
      'description_json': instance.description_json,
      'draft': instance.draft,
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
