// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resend_otp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResendResponse _$ResendResponseFromJson(Map<String, dynamic> json) =>
    ResendResponse(
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ResendResponseToJson(ResendResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
    };

ResendRequest _$ResendRequestFromJson(Map<String, dynamic> json) =>
    ResendRequest(
      phone_number: json['phone_number'] as String,
    );

Map<String, dynamic> _$ResendRequestToJson(ResendRequest instance) =>
    <String, dynamic>{
      'phone_number': instance.phone_number,
    };
