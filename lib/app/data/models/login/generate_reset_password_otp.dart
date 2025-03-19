// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'generate_reset_password_otp.g.dart';

@JsonSerializable()
class GenerateResetPasswordOtpResponse {
  const GenerateResetPasswordOtpResponse({
    this.message,
  });

  factory GenerateResetPasswordOtpResponse.fromJson(
          Map<String, dynamic> json) =>
      _$GenerateResetPasswordOtpResponseFromJson(json);

  final String? message;

  Map<String, dynamic> toJson() =>
      _$GenerateResetPasswordOtpResponseToJson(this);
}

@JsonSerializable()
class GenerateResetPasswordOtpRequest {
  const GenerateResetPasswordOtpRequest({
    required this.phone_number,
  });

  factory GenerateResetPasswordOtpRequest.fromJson(Map<String, dynamic> json) =>
      _$GenerateResetPasswordOtpRequestFromJson(json);

  final String phone_number;

  Map<String, dynamic> toJson() =>
      _$GenerateResetPasswordOtpRequestToJson(this);
}
