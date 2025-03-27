// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'base_document_type.g.dart';

@JsonSerializable()
class BasedocumentCategoryType {
  const BasedocumentCategoryType({
    required this.id,

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

  final String description;
  final String document_category_id;
  final String document_type_id;
  final bool is_required;
  final bool draft;
  final String created_at;

  Map<String, dynamic> toJson() => _$BasedocumentCategoryTypeToJson(this);
}

@JsonSerializable()
class AllowedFileTypes {
  const AllowedFileTypes({required this.types});

  factory AllowedFileTypes.fromJson(Map<String, dynamic> json) =>
      _$AllowedFileTypesFromJson(json);

  final List<String> types;

  Map<String, dynamic> toJson() => _$AllowedFileTypesToJson(this);
}

@JsonSerializable()
class Json {
  const Json({this.en, this.fr});

  factory Json.fromJson(Map<String, dynamic> json) => _$JsonFromJson(json);

  final String? en;
  final String? fr;

  Map<String, dynamic> toJson() => _$JsonToJson(this);
}
