// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'resend_otp.g.dart';

@JsonSerializable()
class ResendResponse {
  const ResendResponse({required this.message});

  factory ResendResponse.fromJson(Map<String, dynamic> json) =>
      _$ResendResponseFromJson(json);

  final String? message;

  Map<String, dynamic> toJson() => _$ResendResponseToJson(this);
}

@JsonSerializable()
class ResendRequest {
  const ResendRequest({required this.phone_number});

  factory ResendRequest.fromJson(Map<String, dynamic> json) =>
      _$ResendRequestFromJson(json);

  final String phone_number;

  Map<String, dynamic> toJson() => _$ResendRequestToJson(this);
}
