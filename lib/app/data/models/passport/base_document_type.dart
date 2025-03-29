// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'base_document_type.g.dart';

@JsonSerializable()
class BasedocumentCategoryType {
  const BasedocumentCategoryType({
    required this.id,
    required this.documentCategory,
    required this.documentType,
    required this.description,
    required this.document_category_id,
    required this.document_type_id,
    required this.is_required,
    required this.draft,
    required this.created_at,
  });

  factory BasedocumentCategoryType.fromJson(Map<String, dynamic> json) =>
      _$BasedocumentCategoryTypeFromJson(json);

  final String id;
  final DocumentCategory documentCategory;
  final DocumentType documentType;
  final dynamic description;
  final dynamic document_category_id;
  final dynamic document_type_id;
  final bool is_required;
  final bool draft;
  final String created_at;

  Map<String, dynamic> toJson() => _$BasedocumentCategoryTypeToJson(this);
}

@JsonSerializable()
class DocumentCategory {
  const DocumentCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.name_json,
    required this.description_json,
  });

  factory DocumentCategory.fromJson(Map<String, dynamic> json) =>
      _$DocumentCategoryFromJson(json);

  final String id;
  final String name;
  final dynamic description;
  final Json name_json;
  final Json description_json;

  Map<String, dynamic> toJson() => _$DocumentCategoryToJson(this);
}

@JsonSerializable()
class DocumentType {
  const DocumentType({
    required this.id,
    required this.name,
    required this.description,
    required this.name_json,
    required this.description_json,
  });

  factory DocumentType.fromJson(Map<String, dynamic> json) =>
      _$DocumentTypeFromJson(json);

  final String id;
  final String name;
  final dynamic description;
  final Json name_json;
  final Json description_json;

  Map<String, dynamic> toJson() => _$DocumentTypeToJson(this);
}

@JsonSerializable()
class Json {
  const Json({this.en, this.fr});

  factory Json.fromJson(Map<String, dynamic> json) => _$JsonFromJson(json);

  final String? en;
  final String? fr;

  Map<String, dynamic> toJson() => _$JsonToJson(this);
}
