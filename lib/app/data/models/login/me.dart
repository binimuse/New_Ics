// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'me.g.dart';

@JsonSerializable()
class UserMeResponse {
  const UserMeResponse({
    this.id,
    this.name,
    this.username,
    this.email,
    this.requirePasswordChange,
    this.licenseApplication,
  });

  factory UserMeResponse.fromJson(Map<String, dynamic> json) =>
      _$UserMeResponseFromJson(json);

  final int? id;
  final String? name;
  final String? username;
  final dynamic email;
  final bool? requirePasswordChange;
  final LicenseApplication? licenseApplication;

  Map<String, dynamic> toJson() => _$UserMeResponseToJson(this);
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

  Map<String, dynamic> toJson() => _$LicenseApplicationToJson(this);
}
