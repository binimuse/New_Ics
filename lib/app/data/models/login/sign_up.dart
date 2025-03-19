// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'sign_up.g.dart';

@JsonSerializable()
class SignUpResponse {
  const SignUpResponse({required this.message});

  factory SignUpResponse.fromJson(Map<String, dynamic> json) =>
      _$SignUpResponseFromJson(json);

  final String? message;

  Map<String, dynamic> toJson() => _$SignUpResponseToJson(this);
}

@JsonSerializable()
class SignUpRequest {
  const SignUpRequest({
    required this.phone_number,
    required this.name,
    required this.password,
  });

  factory SignUpRequest.fromJson(Map<String, dynamic> json) =>
      _$SignUpRequestFromJson(json);

  final String phone_number;
  final String password;
  final String name;

  Map<String, dynamic> toJson() => _$SignUpRequestToJson(this);
}
