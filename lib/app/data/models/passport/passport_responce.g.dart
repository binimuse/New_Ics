// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'passport_responce.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PassportResponce _$PassportResponceFromJson(Map<String, dynamic> json) =>
    PassportResponce(
      message: json['message'] as String,
      data: Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PassportResponceToJson(PassportResponce instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      id: json['id'] as String,
      application_no: json['application_no'] as String,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'application_no': instance.application_no,
    };
