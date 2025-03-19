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
    required this.requirePasswordChage,
    required this.licenseApplication,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  int id;
  dynamic name;
  dynamic username;
  dynamic password;
  dynamic email;

  dynamic requirePasswordChage;
  LicenseApplication licenseApplication;

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class SignInRequest {
  const SignInRequest({
    required this.phone_number,
    required this.password,
  });

  factory SignInRequest.fromJson(Map<String, dynamic> json) =>
      _$SignInRequestFromJson(json);

  final String phone_number;
  final String password;

  Map<String, dynamic> toJson() => _$SignInRequestToJson(this);
}

@JsonSerializable()
class LicenseApplication {
  LicenseApplication({
    this.id,
    this.operator_name,
    this.application_no,
    this.established_date,
    this.manager_first_name,
    this.manager_father_name,
    this.manager_grand_father_name,
    this.woreda,
    this.kebele,
    this.house_number,
    this.mobile_number,
    this.office_phone_number,
    this.email,
    this.p_o_box,
    this.fax,
    this.description,
    this.logo,
    this.user_id,
    this.district_id,
    this.license_application_type_id,
    this.draft,
    this.draftedAt,
    this.createdAt,
    this.updatedAt,
    this.createdById,
    this.updatedById,
    this.tin_number,
    this.trade_registration_number,
    this.organization_type_id,
    this.service_type_id,
    this.requested_license_level_category_id,
    this.submitted,
    this.submitted_at,
    this.rejected,
    this.rejectedAt,
    this.rejectedById,
    this.validated,
    this.validatedAt,
    this.validatedById,
    this.validaterNote,
    this.authorized,
    this.authorizedAt,
    this.authorizedById,
    this.authorizerNote,
    this.verified,
    this.verifiedAt,
    this.verifiedById,
    this.verifierNote,
    this.rejecterNote,
    this.organizationType,
    this.serviceType,
    this.licenseApplicationType,
    this.requestedLicenseLevelCategory,
    this.district,
  });

  factory LicenseApplication.fromJson(Map<String, dynamic> json) =>
      _$LicenseApplicationFromJson(json);

  int? id;
  String? operator_name;
  String? application_no;
  DateTime? established_date;
  String? manager_first_name;
  String? manager_father_name;
  String? manager_grand_father_name;
  String? woreda;
  String? kebele;
  String? house_number;
  String? mobile_number;
  String? office_phone_number;
  String? email;
  String? p_o_box;
  dynamic fax;
  String? description;
  dynamic logo;
  int? user_id;
  int? district_id;
  int? license_application_type_id;
  bool? draft;
  dynamic draftedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic createdById;
  dynamic updatedById;
  String? tin_number;
  String? trade_registration_number;
  int? organization_type_id;
  int? service_type_id;
  int? requested_license_level_category_id;
  bool? submitted;
  DateTime? submitted_at;
  bool? rejected;
  dynamic rejectedAt;
  dynamic rejectedById;
  bool? validated;
  DateTime? validatedAt;
  int? validatedById;
  dynamic validaterNote;
  bool? authorized;
  DateTime? authorizedAt;
  int? authorizedById;
  dynamic authorizerNote;
  bool? verified;
  DateTime? verifiedAt;
  int? verifiedById;
  dynamic verifierNote;
  dynamic rejecterNote;
  District? organizationType;
  District? serviceType;
  District? licenseApplicationType;
  District? requestedLicenseLevelCategory;
  District? district;

  Map<String, dynamic> toJson() => _$LicenseApplicationToJson(this);
}

@JsonSerializable()
class District {
  District({
    this.id,
    this.name,
    this.description,
    this.region,
  });

  factory District.fromJson(Map<String, dynamic> json) =>
      _$DistrictFromJson(json);

  int? id;
  String? name;
  String? description;
  District? region;

  Map<String, dynamic> toJson() => _$DistrictToJson(this);
}
