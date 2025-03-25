// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'base_document_type.g.dart';

@JsonSerializable()
class BasedocumentType {
  const BasedocumentType({
    required this.id,
    required this.name,
    required this.code,
    required this.size,
    required this.min_document_count,
    required this.max_document_count,
    required this.description,
    required this.name_json,
    required this.description_json,
    required this.allowed_file_types,
    required this.check_hint,
    required this.expires,
    required this.draft,
    required this.created_at,
  });

  factory BasedocumentType.fromJson(Map<String, dynamic> json) =>
      _$BasedocumentTypeFromJson(json);

  final String id;
  final String name;
  final String code;
  final int size;
  final int min_document_count;
  final int max_document_count;
  final String description;
  final Json name_json;
  final Json description_json;
  final AllowedFileTypes allowed_file_types;
  final String check_hint;
  final bool expires;
  final bool draft;
  final String created_at;

  Map<String, dynamic> toJson() => _$BasedocumentTypeToJson(this);
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
