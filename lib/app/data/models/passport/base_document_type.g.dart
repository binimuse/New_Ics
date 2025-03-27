// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_document_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasedocumentCategoryType _$BasedocumentCategoryTypeFromJson(
        Map<String, dynamic> json) =>
    BasedocumentCategoryType(
      id: json['id'] as String,
      description: json['description'] as String,
      document_category_id: json['document_category_id'] as String,
      document_type_id: json['document_type_id'] as String,
      is_required: json['is_required'] as bool,
      draft: json['draft'] as bool,
      created_at: json['created_at'] as String,
    );

Map<String, dynamic> _$BasedocumentCategoryTypeToJson(
        BasedocumentCategoryType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'document_category_id': instance.document_category_id,
      'document_type_id': instance.document_type_id,
      'is_required': instance.is_required,
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
