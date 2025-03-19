// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'reset_password.g.dart';

@JsonSerializable()
class ResetpasswordResponse {
  const ResetpasswordResponse({
    this.message,
  });

  factory ResetpasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ResetpasswordResponseFromJson(json);

  final String? message;

  Map<String, dynamic> toJson() => _$ResetpasswordResponseToJson(this);
}

@JsonSerializable()
class ResetpasswordRequest {
  const ResetpasswordRequest({
    required this.otp,
    required this.phone_number,
    required this.password,
  });

  factory ResetpasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ResetpasswordRequestFromJson(json);

  final String otp;
  final String phone_number;
  final String password;

  Map<String, dynamic> toJson() => _$ResetpasswordRequestToJson(this);
}
