// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_document_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasedocumentCategoryType _$BasedocumentCategoryTypeFromJson(
        Map<String, dynamic> json) =>
    BasedocumentCategoryType(
      id: json['id'] as String,
      documentCategory: DocumentCategory.fromJson(
          json['documentCategory'] as Map<String, dynamic>),
      documentType:
          DocumentType.fromJson(json['documentType'] as Map<String, dynamic>),
      description: json['description'],
      document_category_id: json['document_category_id'],
      document_type_id: json['document_type_id'],
      is_required: json['is_required'] as bool,
      draft: json['draft'] as bool,
      created_at: json['created_at'] as String,
    );

Map<String, dynamic> _$BasedocumentCategoryTypeToJson(
        BasedocumentCategoryType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'documentCategory': instance.documentCategory,
      'documentType': instance.documentType,
      'description': instance.description,
      'document_category_id': instance.document_category_id,
      'document_type_id': instance.document_type_id,
      'is_required': instance.is_required,
      'draft': instance.draft,
      'created_at': instance.created_at,
    };

DocumentCategory _$DocumentCategoryFromJson(Map<String, dynamic> json) =>
    DocumentCategory(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'],
      name_json: Json.fromJson(json['name_json'] as Map<String, dynamic>),
      description_json:
          Json.fromJson(json['description_json'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DocumentCategoryToJson(DocumentCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'name_json': instance.name_json,
      'description_json': instance.description_json,
    };

DocumentType _$DocumentTypeFromJson(Map<String, dynamic> json) => DocumentType(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'],
      name_json: Json.fromJson(json['name_json'] as Map<String, dynamic>),
      description_json:
          Json.fromJson(json['description_json'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DocumentTypeToJson(DocumentType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'name_json': instance.name_json,
      'description_json': instance.description_json,
    };

Json _$JsonFromJson(Map<String, dynamic> json) => Json(
      en: json['en'] as String?,
      fr: json['fr'] as String?,
    );

Map<String, dynamic> _$JsonToJson(Json instance) => <String, dynamic>{
      'en': instance.en,
      'fr': instance.fr,
    };
