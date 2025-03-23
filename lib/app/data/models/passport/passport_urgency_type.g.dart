// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'passport_urgency_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasePassportUrgencyType _$BasePassportUrgencyTypeFromJson(
        Map<String, dynamic> json) =>
    BasePassportUrgencyType(
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
      priority: (json['priority'] as num).toInt(),
      for_abroad: json['for_abroad'] as bool,
      processing_days_count: (json['processing_days_count'] as num).toInt(),
      created_at: json['created_at'] as String?,
      updated_at: json['updated_at'] as String?,
    );

Map<String, dynamic> _$BasePassportUrgencyTypeToJson(
        BasePassportUrgencyType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'nameJson': instance.nameJson,
      'description': instance.description,
      'description_json': instance.description_json,
      'draft': instance.draft,
      'for_abroad': instance.for_abroad,
      'drafted_at': instance.drafted_at,
      'priority': instance.priority,
      'processing_days_count': instance.processing_days_count,
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
