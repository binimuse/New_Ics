// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_document_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasedocumentType _$BasedocumentTypeFromJson(Map<String, dynamic> json) =>
    BasedocumentType(
      id: json['id'] as String,
      name: json['name'] as String,
      code: json['code'] as String,
      size: (json['size'] as num).toInt(),
      min_document_count: (json['min_document_count'] as num).toInt(),
      max_document_count: (json['max_document_count'] as num).toInt(),
      description: json['description'] as String,
      name_json: Json.fromJson(json['name_json'] as Map<String, dynamic>),
      description_json:
          Json.fromJson(json['description_json'] as Map<String, dynamic>),
      allowed_file_types: AllowedFileTypes.fromJson(
          json['allowed_file_types'] as Map<String, dynamic>),
      check_hint: json['check_hint'] as String,
      expires: json['expires'] as bool,
      draft: json['draft'] as bool,
      created_at: json['created_at'] as String,
    );

Map<String, dynamic> _$BasedocumentTypeToJson(BasedocumentType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'size': instance.size,
      'min_document_count': instance.min_document_count,
      'max_document_count': instance.max_document_count,
      'description': instance.description,
      'name_json': instance.name_json,
      'description_json': instance.description_json,
      'allowed_file_types': instance.allowed_file_types,
      'check_hint': instance.check_hint,
      'expires': instance.expires,
      'draft': instance.draft,
      'created_at': instance.created_at,
    };

AllowedFileTypes _$AllowedFileTypesFromJson(Map<String, dynamic> json) =>
    AllowedFileTypes(
      types: (json['types'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$AllowedFileTypesToJson(AllowedFileTypes instance) =>
    <String, dynamic>{
      'types': instance.types,
    };

Json _$JsonFromJson(Map<String, dynamic> json) => Json(
      en: json['en'] as String?,
      fr: json['fr'] as String?,
    );

Map<String, dynamic> _$JsonToJson(Json instance) => <String, dynamic>{
      'en': instance.en,
      'fr': instance.fr,
    };
