// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_password.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangePasswordResponse _$ChangePasswordResponseFromJson(
        Map<String, dynamic> json) =>
    ChangePasswordResponse(
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ChangePasswordResponseToJson(
        ChangePasswordResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
    };

ChangePasswordRequest _$ChangePasswordRequestFromJson(
        Map<String, dynamic> json) =>
    ChangePasswordRequest(
      previous_password: json['previous_password'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$ChangePasswordRequestToJson(
        ChangePasswordRequest instance) =>
    <String, dynamic>{
      'previous_password': instance.previous_password,
      'password': instance.password,
    };
