// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'deactivate_account.g.dart';

@JsonSerializable()
class DeactivateAccountResponse {
  const DeactivateAccountResponse({
    this.message,
  });

  factory DeactivateAccountResponse.fromJson(Map<String, dynamic> json) =>
      _$DeactivateAccountResponseFromJson(json);

  final String? message;

  Map<String, dynamic> toJson() => _$DeactivateAccountResponseToJson(this);
}

@JsonSerializable()
class DeactivateAccountRequest {
  const DeactivateAccountRequest({
    required this.user_id,
    required this.deactivation_reason_id,
  });

  factory DeactivateAccountRequest.fromJson(Map<String, dynamic> json) =>
      _$DeactivateAccountRequestFromJson(json);

  final String user_id;
  final String deactivation_reason_id;

  Map<String, dynamic> toJson() => _$DeactivateAccountRequestToJson(this);
}
