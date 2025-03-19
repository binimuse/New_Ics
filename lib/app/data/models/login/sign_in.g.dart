// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignInResponse _$SignInResponseFromJson(Map<String, dynamic> json) =>
    SignInResponse(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SignInResponseToJson(SignInResponse instance) =>
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
      licenseApplication: LicenseApplication.fromJson(
          json['licenseApplication'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'username': instance.username,
      'password': instance.password,
      'email': instance.email,
      'requirePasswordChage': instance.requirePasswordChage,
      'licenseApplication': instance.licenseApplication,
    };

SignInRequest _$SignInRequestFromJson(Map<String, dynamic> json) =>
    SignInRequest(
      phone_number: json['phone_number'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$SignInRequestToJson(SignInRequest instance) =>
    <String, dynamic>{
      'phone_number': instance.phone_number,
      'password': instance.password,
    };

LicenseApplication _$LicenseApplicationFromJson(Map<String, dynamic> json) =>
    LicenseApplication(
      id: (json['id'] as num?)?.toInt(),
      operator_name: json['operator_name'] as String?,
      application_no: json['application_no'] as String?,
      established_date: json['established_date'] == null
          ? null
          : DateTime.parse(json['established_date'] as String),
      manager_first_name: json['manager_first_name'] as String?,
      manager_father_name: json['manager_father_name'] as String?,
      manager_grand_father_name: json['manager_grand_father_name'] as String?,
      woreda: json['woreda'] as String?,
      kebele: json['kebele'] as String?,
      house_number: json['house_number'] as String?,
      mobile_number: json['mobile_number'] as String?,
      office_phone_number: json['office_phone_number'] as String?,
      email: json['email'] as String?,
      p_o_box: json['p_o_box'] as String?,
      fax: json['fax'],
      description: json['description'] as String?,
      logo: json['logo'],
      user_id: (json['user_id'] as num?)?.toInt(),
      district_id: (json['district_id'] as num?)?.toInt(),
      license_application_type_id:
          (json['license_application_type_id'] as num?)?.toInt(),
      draft: json['draft'] as bool?,
      draftedAt: json['draftedAt'],
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      createdById: json['createdById'],
      updatedById: json['updatedById'],
      tin_number: json['tin_number'] as String?,
      trade_registration_number: json['trade_registration_number'] as String?,
      organization_type_id: (json['organization_type_id'] as num?)?.toInt(),
      service_type_id: (json['service_type_id'] as num?)?.toInt(),
      requested_license_level_category_id:
          (json['requested_license_level_category_id'] as num?)?.toInt(),
      submitted: json['submitted'] as bool?,
      submitted_at: json['submitted_at'] == null
          ? null
          : DateTime.parse(json['submitted_at'] as String),
      rejected: json['rejected'] as bool?,
      rejectedAt: json['rejectedAt'],
      rejectedById: json['rejectedById'],
      validated: json['validated'] as bool?,
      validatedAt: json['validatedAt'] == null
          ? null
          : DateTime.parse(json['validatedAt'] as String),
      validatedById: (json['validatedById'] as num?)?.toInt(),
      validaterNote: json['validaterNote'],
      authorized: json['authorized'] as bool?,
      authorizedAt: json['authorizedAt'] == null
          ? null
          : DateTime.parse(json['authorizedAt'] as String),
      authorizedById: (json['authorizedById'] as num?)?.toInt(),
      authorizerNote: json['authorizerNote'],
      verified: json['verified'] as bool?,
      verifiedAt: json['verifiedAt'] == null
          ? null
          : DateTime.parse(json['verifiedAt'] as String),
      verifiedById: (json['verifiedById'] as num?)?.toInt(),
      verifierNote: json['verifierNote'],
      rejecterNote: json['rejecterNote'],
      organizationType: json['organizationType'] == null
          ? null
          : District.fromJson(json['organizationType'] as Map<String, dynamic>),
      serviceType: json['serviceType'] == null
          ? null
          : District.fromJson(json['serviceType'] as Map<String, dynamic>),
      licenseApplicationType: json['licenseApplicationType'] == null
          ? null
          : District.fromJson(
              json['licenseApplicationType'] as Map<String, dynamic>),
      requestedLicenseLevelCategory: json['requestedLicenseLevelCategory'] ==
              null
          ? null
          : District.fromJson(
              json['requestedLicenseLevelCategory'] as Map<String, dynamic>),
      district: json['district'] == null
          ? null
          : District.fromJson(json['district'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LicenseApplicationToJson(LicenseApplication instance) =>
    <String, dynamic>{
      'id': instance.id,
      'operator_name': instance.operator_name,
      'application_no': instance.application_no,
      'established_date': instance.established_date?.toIso8601String(),
      'manager_first_name': instance.manager_first_name,
      'manager_father_name': instance.manager_father_name,
      'manager_grand_father_name': instance.manager_grand_father_name,
      'woreda': instance.woreda,
      'kebele': instance.kebele,
      'house_number': instance.house_number,
      'mobile_number': instance.mobile_number,
      'office_phone_number': instance.office_phone_number,
      'email': instance.email,
      'p_o_box': instance.p_o_box,
      'fax': instance.fax,
      'description': instance.description,
      'logo': instance.logo,
      'user_id': instance.user_id,
      'district_id': instance.district_id,
      'license_application_type_id': instance.license_application_type_id,
      'draft': instance.draft,
      'draftedAt': instance.draftedAt,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'createdById': instance.createdById,
      'updatedById': instance.updatedById,
      'tin_number': instance.tin_number,
      'trade_registration_number': instance.trade_registration_number,
      'organization_type_id': instance.organization_type_id,
      'service_type_id': instance.service_type_id,
      'requested_license_level_category_id':
          instance.requested_license_level_category_id,
      'submitted': instance.submitted,
      'submitted_at': instance.submitted_at?.toIso8601String(),
      'rejected': instance.rejected,
      'rejectedAt': instance.rejectedAt,
      'rejectedById': instance.rejectedById,
      'validated': instance.validated,
      'validatedAt': instance.validatedAt?.toIso8601String(),
      'validatedById': instance.validatedById,
      'validaterNote': instance.validaterNote,
      'authorized': instance.authorized,
      'authorizedAt': instance.authorizedAt?.toIso8601String(),
      'authorizedById': instance.authorizedById,
      'authorizerNote': instance.authorizerNote,
      'verified': instance.verified,
      'verifiedAt': instance.verifiedAt?.toIso8601String(),
      'verifiedById': instance.verifiedById,
      'verifierNote': instance.verifierNote,
      'rejecterNote': instance.rejecterNote,
      'organizationType': instance.organizationType,
      'serviceType': instance.serviceType,
      'licenseApplicationType': instance.licenseApplicationType,
      'requestedLicenseLevelCategory': instance.requestedLicenseLevelCategory,
      'district': instance.district,
    };

District _$DistrictFromJson(Map<String, dynamic> json) => District(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      description: json['description'] as String?,
      region: json['region'] == null
          ? null
          : District.fromJson(json['region'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DistrictToJson(District instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'region': instance.region,
    };
