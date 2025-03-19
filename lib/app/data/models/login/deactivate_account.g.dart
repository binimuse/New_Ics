// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deactivate_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeactivateAccountResponse _$DeactivateAccountResponseFromJson(
        Map<String, dynamic> json) =>
    DeactivateAccountResponse(
      message: json['message'] as String?,
    );

Map<String, dynamic> _$DeactivateAccountResponseToJson(
        DeactivateAccountResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
    };

DeactivateAccountRequest _$DeactivateAccountRequestFromJson(
        Map<String, dynamic> json) =>
    DeactivateAccountRequest(
      user_id: json['user_id'] as String,
      deactivation_reason_id: json['deactivation_reason_id'] as String,
    );

Map<String, dynamic> _$DeactivateAccountRequestToJson(
        DeactivateAccountRequest instance) =>
    <String, dynamic>{
      'user_id': instance.user_id,
      'deactivation_reason_id': instance.deactivation_reason_id,
    };
