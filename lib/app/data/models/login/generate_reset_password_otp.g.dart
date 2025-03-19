// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generate_reset_password_otp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenerateResetPasswordOtpResponse _$GenerateResetPasswordOtpResponseFromJson(
        Map<String, dynamic> json) =>
    GenerateResetPasswordOtpResponse(
      message: json['message'] as String?,
    );

Map<String, dynamic> _$GenerateResetPasswordOtpResponseToJson(
        GenerateResetPasswordOtpResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
    };

GenerateResetPasswordOtpRequest _$GenerateResetPasswordOtpRequestFromJson(
        Map<String, dynamic> json) =>
    GenerateResetPasswordOtpRequest(
      phone_number: json['phone_number'] as String,
    );

Map<String, dynamic> _$GenerateResetPasswordOtpRequestToJson(
        GenerateResetPasswordOtpRequest instance) =>
    <String, dynamic>{
      'phone_number': instance.phone_number,
    };
