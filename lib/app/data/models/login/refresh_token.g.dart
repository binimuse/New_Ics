// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenRefreshResponse _$TokenRefreshResponseFromJson(
        Map<String, dynamic> json) =>
    TokenRefreshResponse(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TokenRefreshResponseToJson(
        TokenRefreshResponse instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'user': instance.user,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: (json['id'] as num).toInt(),
      name: json['name'],
      username: json['username'],
      password: json['password'],
      email: json['email'],
      requirePasswordChage: json['requirePasswordChage'],
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'username': instance.username,
      'password': instance.password,
      'email': instance.email,
      'requirePasswordChage': instance.requirePasswordChage,
    };
