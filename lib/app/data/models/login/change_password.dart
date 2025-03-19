// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'change_password.g.dart';

@JsonSerializable()
class ChangePasswordResponse {
  const ChangePasswordResponse({
    this.message,
  });

  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordResponseFromJson(json);

  final String? message;

  Map<String, dynamic> toJson() => _$ChangePasswordResponseToJson(this);
}

@JsonSerializable()
class ChangePasswordRequest {
  const ChangePasswordRequest({
    required this.previous_password,
    required this.password,
  });

  factory ChangePasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordRequestFromJson(json);

  final String previous_password;
  final String password;

  Map<String, dynamic> toJson() => _$ChangePasswordRequestToJson(this);
}
