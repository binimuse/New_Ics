// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'verify_otp.g.dart';

@JsonSerializable()
class VerifyResponse {
  const VerifyResponse({
    required this.message,
    required this.error,
    required this.statusCode,
  });

  factory VerifyResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyResponseFromJson(json);

  final String? message;
  final String? error;
  final String? statusCode;

  Map<String, dynamic> toJson() => _$VerifyResponseToJson(this);
}

@JsonSerializable()
class VerifyRequest {
  const VerifyRequest({required this.otp, required this.phone_number});

  factory VerifyRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyRequestFromJson(json);

  final String otp;
  final String phone_number;

  Map<String, dynamic> toJson() => _$VerifyRequestToJson(this);
}
