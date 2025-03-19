// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'refresh_token.g.dart';

@JsonSerializable()
class TokenRefreshResponse {
  const TokenRefreshResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory TokenRefreshResponse.fromJson(Map<String, dynamic> json) =>
      _$TokenRefreshResponseFromJson(json);

  final String accessToken;
  final String refreshToken;
  final User user;

  Map<String, dynamic> toJson() => _$TokenRefreshResponseToJson(this);
}

@JsonSerializable()
class User {
  User({
    required this.id,
    required this.name,
    required this.username,
    required this.password,
    required this.email,
    required this.requirePasswordChage,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  int id;
  dynamic name;
  dynamic username;
  dynamic password;
  dynamic email;

  dynamic requirePasswordChage;

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
