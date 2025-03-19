// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResetpasswordResponse _$ResetpasswordResponseFromJson(
        Map<String, dynamic> json) =>
    ResetpasswordResponse(
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ResetpasswordResponseToJson(
        ResetpasswordResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
    };

ResetpasswordRequest _$ResetpasswordRequestFromJson(
        Map<String, dynamic> json) =>
    ResetpasswordRequest(
      otp: json['otp'] as String,
      phone_number: json['phone_number'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$ResetpasswordRequestToJson(
        ResetpasswordRequest instance) =>
    <String, dynamic>{
      'otp': instance.otp,
      'phone_number': instance.phone_number,
      'password': instance.password,
    };
