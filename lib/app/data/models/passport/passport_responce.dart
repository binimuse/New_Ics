// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'passport_responce.g.dart';

@JsonSerializable()
class PassportResponce {
  const PassportResponce({required this.message, required this.data});

  factory PassportResponce.fromJson(Map<String, dynamic> json) =>
      _$PassportResponceFromJson(json);

  final String message;
  final Data data;

  Map<String, dynamic> toJson() => _$PassportResponceToJson(this);
}

@JsonSerializable()
class Data {
  const Data({required this.id, required this.application_no});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  final String id;
  final String application_no;

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
