// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'passport_responce.g.dart';

@JsonSerializable()
class PassportResponce {
  const PassportResponce({required this.id});

  factory PassportResponce.fromJson(Map<String, dynamic> json) =>
      _$PassportResponceFromJson(json);

  final String id;

  Map<String, dynamic> toJson() => _$PassportResponceToJson(this);
}
