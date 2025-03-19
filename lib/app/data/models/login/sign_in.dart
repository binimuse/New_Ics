// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'sign_in.g.dart';

@JsonSerializable()
class SignInResponse {
  const SignInResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory SignInResponse.fromJson(Map<String, dynamic> json) =>
      _$SignInResponseFromJson(json);

  final String accessToken;
  final String refreshToken;
  final User user;

  Map<String, dynamic> toJson() => _$SignInResponseToJson(this);
}

@JsonSerializable()
class User {
  User({
    required this.id,
    required this.name,
    required this.username,
    required this.password,
    required this.email,
    required this.require_password_change,
    required this.phone_otp_verified,
    required this.is_active,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  String id;
  String name;
  String username;
  String password;
  dynamic email;

  bool require_password_change;
  bool phone_otp_verified;
  bool is_active;

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class SignInRequest {
  const SignInRequest({required this.phone_number, required this.password});

  factory SignInRequest.fromJson(Map<String, dynamic> json) =>
      _$SignInRequestFromJson(json);

  final String phone_number;
  final String password;

  Map<String, dynamic> toJson() => _$SignInRequestToJson(this);
}
