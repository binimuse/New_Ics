class IcsApplication {
  String applicationType;
  List<dynamic> citizenFamilies;
  String createdAt;
  String? deliveryStatus;
  String firstName;
  String fatherName;
  String grandFatherName;
  NameJson fatherNameJson;
  NameJson firstNameJson;
  String? photo;
  String gender;
  NameJson grandFatherNameJson;
  BirthCountry birthCountry;
  DateTime dateOfBirth;
  String abroadAddress;
  String birthPlace;
  String? eyeColour;
  String? hairColour;
  double? height;
  String id;
  bool isAdopted;
  String maritalStatus;
  String reviewStatus;
  String? house_number;

  CurrentCountry? serviceUrgencyLevel;
  CurrentCountry nationality;
  CurrentCountry? occupation;
  CurrentCountry currentCountry;
  String embassyId;
  String phoneNumber;
  String skinColour;
  List<ApplicationAppointment> applicationAppointments;
  List<ApplicationDocument> applicationDocuments;
  List<NewOriginIdApplication> newOriginIdApplications;
  List<NewPassportApplication> newPassportApplications;
  List<RenewPassportApplication> renewPassportApplications;
  List<RenewalOriginIdApplication> renewalOriginIdApplications;
  List<NewTravelDocumentApplication> newTravelDocumentApplications;

  IcsApplication({
    required this.applicationType,
    required this.citizenFamilies,
    required this.createdAt,
    this.deliveryStatus,
    required this.firstName,
    required this.fatherName,
    required this.grandFatherName,
    required this.fatherNameJson,
    required this.firstNameJson,
    this.photo,
    this.house_number,
    this.serviceUrgencyLevel,
    required this.gender,
    required this.grandFatherNameJson,
    required this.birthCountry,
    required this.dateOfBirth,
    required this.abroadAddress,
    required this.birthPlace,
    required this.eyeColour,
    required this.hairColour,
    required this.height,
    required this.id,
    required this.isAdopted,
    required this.maritalStatus,
    required this.reviewStatus,
    required this.nationality,
    required this.occupation,
    required this.currentCountry,
    required this.embassyId,
    required this.phoneNumber,
    required this.skinColour,
    required this.applicationAppointments,
    required this.applicationDocuments,
    required this.newOriginIdApplications,
    required this.newPassportApplications,
    required this.renewPassportApplications,
    required this.renewalOriginIdApplications,
    required this.newTravelDocumentApplications,
  });

  factory IcsApplication.fromMap(Map<String, dynamic> json) => IcsApplication(
        applicationType: json["application_type"],
        citizenFamilies:
            List<dynamic>.from(json["citizen_families"].map((x) => x)),
        createdAt: json["created_at"],
        firstName: json["first_name"],
        deliveryStatus: json["delivery_status"],
        fatherName: json["father_name"],
        grandFatherName: json["grand_father_name"],
        fatherNameJson: NameJson.fromMap(json["father_name_json"]),
        firstNameJson: NameJson.fromMap(json["first_name_json"]),
        photo: json["photo"] as String? ?? '',
        gender: json["gender"],
        grandFatherNameJson: NameJson.fromMap(json["grand_father_name_json"]),
        birthCountry: BirthCountry.fromMap(json["birth_country"]),
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
        abroadAddress: json["abroad_address"],
        birthPlace: json["birth_place"],
        eyeColour: json["eye_colour"],
        hairColour: json["hair_colour"],
        height: json["height"]?.toDouble(),
        id: json["id"],
        isAdopted: json["is_adopted"],
        maritalStatus: json["marital_status"],
        reviewStatus: json["review_status"],
        serviceUrgencyLevel: json["service_urgency_level"] == null
            ? null
            : CurrentCountry.fromMap(json["service_urgency_level"]),
        house_number: json["house_number"],
        nationality: CurrentCountry.fromMap(json["nationality"]),
        occupation: json["occupation"] == null
            ? null
            : CurrentCountry.fromMap(json["occupation"]),
        currentCountry: CurrentCountry.fromMap(json["current_country"]),
        embassyId: json["embassy_id"],
        phoneNumber: json["phone_number"],
        skinColour: json["skin_colour"],
        applicationAppointments: List<ApplicationAppointment>.from(
            json["application_appointments"]
                .map((x) => ApplicationAppointment.fromMap(x))),
        applicationDocuments: json["application_documents"] == null
            ? []
            : List<ApplicationDocument>.from(json["application_documents"]
                .map((x) => ApplicationDocument.fromMap(x ?? {}))),
        newOriginIdApplications: json["new_origin_id_applications"] == null
            ? []
            : List<NewOriginIdApplication>.from(
                json["new_origin_id_applications"]
                    .map((x) => NewOriginIdApplication.fromMap(x))),
        newPassportApplications: List<NewPassportApplication>.from(
            json["new_passport_applications"]
                .map((x) => NewPassportApplication.fromMap(x))),
        renewPassportApplications: List<RenewPassportApplication>.from(
            json["renew_passport_applications"]
                .map((x) => RenewPassportApplication.fromMap(x))),
        renewalOriginIdApplications: List<RenewalOriginIdApplication>.from(
            json["renewal_origin_id_applications"]
                .map((x) => RenewalOriginIdApplication.fromMap(x))),
        newTravelDocumentApplications: List<NewTravelDocumentApplication>.from(
            json["new_travel_document_applications"]
                .map((x) => NewTravelDocumentApplication.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "application_type": applicationType,
        "citizen_families": List<dynamic>.from(citizenFamilies.map((x) => x)),
        "created_at": createdAt,
        "delivery_status": deliveryStatus,
        "first_name": firstName,
        "father_name": fatherName,
        "grand_father_name": grandFatherName,
        "father_name_json": fatherNameJson.toMap(),
        "first_name_json": firstNameJson.toMap(),
        "photo": photo,
        "gender": gender,
        "grand_father_name_json": grandFatherNameJson.toMap(),
        "birth_country": birthCountry.toMap(),
        "date_of_birth":
            "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
        "abroad_address": abroadAddress,
        "birth_place": birthPlace,
        "eye_colour": eyeColour,
        "hair_colour": hairColour,
        "height": height,
        "id": id,
        "is_adopted": isAdopted,
        "marital_status": maritalStatus,
        "review_status": reviewStatus,
        "nationality": nationality.toMap(),
        "occupation": occupation?.toMap(),
        "current_country": currentCountry.toMap(),
        "embassy_id": embassyId,
        "phone_number": phoneNumber,
        "skin_colour": skinColour,
        "house_number": house_number,
        "service_urgency_level": serviceUrgencyLevel?.toMap(),
        "application_appointments":
            List<dynamic>.from(applicationAppointments.map((x) => x.toMap())),
        "application_documents":
            List<dynamic>.from(applicationDocuments.map((x) => x.toMap())),
        "new_origin_id_applications":
            List<dynamic>.from(newOriginIdApplications.map((x) => x.toMap())),
        "new_passport_applications":
            List<dynamic>.from(newPassportApplications.map((x) => x.toMap())),
        "renew_passport_applications":
            List<dynamic>.from(renewPassportApplications.map((x) => x.toMap())),
        "renewal_origin_id_applications": List<dynamic>.from(
            renewalOriginIdApplications.map((x) => x.toMap())),
        "new_travel_document_applications": List<dynamic>.from(
            newTravelDocumentApplications.map((x) => x.toMap())),
      };
}

class PassportPrice {
  final String? id;
  final int? priceEtb;
  final int? priceUsd;

  PassportPrice({
    this.id,
    this.priceEtb,
    this.priceUsd,
  });

  factory PassportPrice.fromMap(Map<String, dynamic> json) => PassportPrice(
        id: json["id"],
        priceEtb: json["price_etb"],
        priceUsd: json["price_usd"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "price_etb": priceEtb,
        "price_usd": priceUsd,
      };
}

class ApplicationAppointment {
  DateTime date;
  String startTime;
  bool rescheduled;

  ApplicationAppointment({
    required this.date,
    required this.startTime,
    required this.rescheduled,
  });

  factory ApplicationAppointment.fromMap(Map<String, dynamic> json) =>
      ApplicationAppointment(
        date: DateTime.parse(json["date"]),
        startTime: json["start_time"],
        rescheduled: json["rescheduled"],
      );

  Map<String, dynamic> toMap() => {
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "start_time": startTime,
        "rescheduled": rescheduled,
      };
}

class ApplicationDocument {
  String documentStatus;
  CurrentCountry documentType;
  String? rejectionReason;
  Files files;
  dynamic rejected;
  String id;

  ApplicationDocument({
    required this.documentStatus,
    required this.documentType,
    required this.rejectionReason,
    required this.files,
    required this.rejected,
    required this.id,
  });

  factory ApplicationDocument.fromMap(Map<String, dynamic> json) =>
      ApplicationDocument(
        documentStatus: json["document_status"],
        rejectionReason: json["rejection_reason"],
        documentType: json["document_type"] == null
            ? CurrentCountry.fromMap({})
            : CurrentCountry.fromMap(json["document_type"]),
        files: json["files"] == null
            ? Files.fromMap({})
            : Files.fromMap(json["files"]),
        rejected: json["rejected"],
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "document_status": documentStatus,
        "document_type": documentType.toMap(),
        "rejection_reason": rejectionReason,
        "files": files.toMap(),
        "rejected": rejected,
        "id": id,
      };
}

class CurrentCountry {
  String id;
  String name;

  CurrentCountry({
    required this.id,
    required this.name,
  });

  factory CurrentCountry.fromMap(Map<String, dynamic> json) => CurrentCountry(
        id: json["id"] ?? '',
        name: json["name"] ?? '',
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}

class Files {
  String path;

  Files({
    required this.path,
  });

  factory Files.fromMap(Map<String, dynamic> json) => Files(
        path: json["path"] ?? '', // Provide a default value if path is null
      );

  Map<String, dynamic> toMap() => {
        "path": path,
      };
}

class BirthCountry {
  String name;

  BirthCountry({
    required this.name,
  });

  factory BirthCountry.fromMap(Map<String, dynamic> json) => BirthCountry(
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
      };
}

class NameJson {
  String am;
  String en;

  NameJson({
    required this.am,
    required this.en,
  });

  factory NameJson.fromMap(Map<String, dynamic> json) => NameJson(
        am: json["am"],
        en: json["en"],
      );

  Map<String, dynamic> toMap() => {
        "am": am,
        "en": en,
      };
}

class NewOriginIdApplication {
  String createdAt;
  String applicationNo;
  String applicationId;
  DateTime currentPassportExpiryDate;
  DateTime currentPassportIssuedDate;
  String currentPassportNumber;
  dynamic etPassportExpiryDate;
  String visaNumber;
  dynamic signature;
  CurrentCountry visaType;

  NewOriginIdApplication({
    required this.createdAt,
    required this.applicationNo,
    required this.applicationId,
    required this.currentPassportExpiryDate,
    required this.currentPassportIssuedDate,
    required this.currentPassportNumber,
    required this.etPassportExpiryDate,
    required this.visaNumber,
    required this.signature,
    required this.visaType,
  });

  factory NewOriginIdApplication.fromMap(Map<String, dynamic> json) =>
      NewOriginIdApplication(
        createdAt: json["created_at"],
        applicationNo: json["application_no"],
        applicationId: json["application_id"],
        currentPassportExpiryDate:
            DateTime.parse(json["current_passport_expiry_date"]),
        currentPassportIssuedDate:
            DateTime.parse(json["current_passport_issued_date"]),
        currentPassportNumber: json["current_passport_number"],
        etPassportExpiryDate: json["et_passport_expiry_date"],
        visaNumber: json["visa_number"],
        signature: json["signature"],
        visaType: json["visa_type"] == null
            ? CurrentCountry.fromMap({})
            : CurrentCountry.fromMap(json["visa_type"]),
      );

  Map<String, dynamic> toMap() => {
        "created_at": createdAt,
        "application_no": applicationNo,
        "application_id": applicationId,
        "current_passport_expiry_date":
            "${currentPassportExpiryDate.year.toString().padLeft(4, '0')}-${currentPassportExpiryDate.month.toString().padLeft(2, '0')}-${currentPassportExpiryDate.day.toString().padLeft(2, '0')}",
        "current_passport_issued_date":
            "${currentPassportIssuedDate.year.toString().padLeft(4, '0')}-${currentPassportIssuedDate.month.toString().padLeft(2, '0')}-${currentPassportIssuedDate.day.toString().padLeft(2, '0')}",
        "current_passport_number": currentPassportNumber,
        "et_passport_expiry_date": etPassportExpiryDate,
        "visa_number": visaNumber,
        "signature": signature,
        "visa_type": visaType.toMap(),
      };
}

class NewPassportApplication {
  final String? createdAt;
  final String? applicationNo;
  final CurrentCountry? passportPageSize;
  final CurrentCountry? passportType;
  final PassportPrice? passportPrice;

  NewPassportApplication({
    this.createdAt,
    this.applicationNo,
    this.passportPageSize,
    this.passportType,
    this.passportPrice,
  });

  factory NewPassportApplication.fromMap(Map<String, dynamic> json) =>
      NewPassportApplication(
        createdAt: json["created_at"],
        applicationNo: json["application_no"],
        passportPageSize: json["passport_page_size"] == null
            ? null
            : CurrentCountry.fromMap(json["passport_page_size"]),
        passportType: json["passport_type"] == null
            ? null
            : CurrentCountry.fromMap(json["passport_type"]),
        passportPrice: json["passport_price"] == null
            ? null
            : PassportPrice.fromMap(json["passport_price"]),
      );

  Map<String, dynamic> toMap() => {
        "created_at": createdAt,
        "application_no": applicationNo,
        "passport_page_size": passportPageSize?.toMap(),
        "passport_type": passportType?.toMap(),
        "passport_price": passportPrice?.toMap(),
      };
}

class RenewPassportApplication {
  DateTime? deliveryDate;
  String passportNumber;
  String applicationNo;
  dynamic correctionType;
  CurrentCountry passportRenewalType;
  String id;

  RenewPassportApplication({
    required this.passportNumber,
    this.deliveryDate,
    required this.applicationNo,
    required this.correctionType,
    required this.passportRenewalType,
    required this.id,
  });

  factory RenewPassportApplication.fromMap(Map<String, dynamic> json) =>
      RenewPassportApplication(
        passportNumber: json["passport_number"],
        deliveryDate: json["delivery_date"] == null
            ? null
            : DateTime.parse(json["delivery_date"]),
        applicationNo: json["application_no"],
        correctionType: json["correction_type"],
        passportRenewalType:
            CurrentCountry.fromMap(json["passport_renewal_type"]),
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "delivery_date":
            "${deliveryDate!.year.toString().padLeft(4, '0')}-${deliveryDate!.month.toString().padLeft(2, '0')}-${deliveryDate!.day.toString().padLeft(2, '0')}",
        "passport_number": passportNumber,
        "application_no": applicationNo,
        "correction_type": correctionType,
        "passport_renewal_type": passportRenewalType.toMap(),
        "id": id,
      };
}

class RenewalOriginIdApplication {
  CurrentCountry originIdRenewalType;
  String applicationNo;
  String createdAt;
  String currentPassportNumber;
  String visaNumber;
  CurrentCountry visaType;
  DateTime currentPassportExpiryDate;
  DateTime currentPassportIssuedDate;
  DateTime visaExpiryDate;
  DateTime visaIssuedDate;
  String originIdNumber;

  RenewalOriginIdApplication({
    required this.originIdRenewalType,
    required this.applicationNo,
    required this.createdAt,
    required this.currentPassportNumber,
    required this.visaNumber,
    required this.visaType,
    required this.currentPassportExpiryDate,
    required this.currentPassportIssuedDate,
    required this.visaExpiryDate,
    required this.visaIssuedDate,
    required this.originIdNumber,
  });

  factory RenewalOriginIdApplication.fromMap(Map<String, dynamic> json) =>
      RenewalOriginIdApplication(
        originIdRenewalType:
            CurrentCountry.fromMap(json["origin_id_renewal_type"]),
        applicationNo: json["application_no"],
        createdAt: json["created_at"],
        currentPassportNumber: json["current_passport_number"],
        visaNumber: json["visa_number"],
        visaType: CurrentCountry.fromMap(json["visa_type"]),
        currentPassportExpiryDate:
            DateTime.parse(json["current_passport_expiry_date"]),
        currentPassportIssuedDate:
            DateTime.parse(json["current_passport_issued_date"]),
        visaExpiryDate: DateTime.parse(json["visa_expiry_date"]),
        visaIssuedDate: DateTime.parse(json["visa_issued_date"]),
        originIdNumber: json["origin_id_number"],
      );

  Map<String, dynamic> toMap() => {
        "origin_id_renewal_type": originIdRenewalType.toMap(),
        "application_no": applicationNo,
        "created_at": createdAt,
        "current_passport_number": currentPassportNumber,
        "visa_number": visaNumber,
        "visa_type": visaType.toMap(),
        "current_passport_expiry_date":
            "${currentPassportExpiryDate.year.toString().padLeft(4, '0')}-${currentPassportExpiryDate.month.toString().padLeft(2, '0')}-${currentPassportExpiryDate.day.toString().padLeft(2, '0')}",
        "current_passport_issued_date":
            "${currentPassportIssuedDate.year.toString().padLeft(4, '0')}-${currentPassportIssuedDate.month.toString().padLeft(2, '0')}-${currentPassportIssuedDate.day.toString().padLeft(2, '0')}",
        "visa_expiry_date":
            "${visaExpiryDate.year.toString().padLeft(4, '0')}-${visaExpiryDate.month.toString().padLeft(2, '0')}-${visaExpiryDate.day.toString().padLeft(2, '0')}",
        "visa_issued_date":
            "${visaIssuedDate.year.toString().padLeft(4, '0')}-${visaIssuedDate.month.toString().padLeft(2, '0')}-${visaIssuedDate.day.toString().padLeft(2, '0')}",
        "origin_id_number": originIdNumber,
      };
}

class NewTravelDocumentApplication {
  String applicationId;
  String applicationNo;
  String createdAt;
  String id;
  dynamic remark;
  TravelDocumentType travelDocumentType;

  NewTravelDocumentApplication({
    required this.applicationId,
    required this.applicationNo,
    required this.createdAt,
    required this.id,
    required this.remark,
    required this.travelDocumentType,
  });

  factory NewTravelDocumentApplication.fromMap(Map<String, dynamic> json) =>
      NewTravelDocumentApplication(
        applicationId: json["application_id"],
        applicationNo: json["application_no"],
        createdAt: json["created_at"],
        id: json["id"],
        remark: json["remark"],
        travelDocumentType:
            TravelDocumentType.fromMap(json["travel_document_type"]),
      );

  Map<String, dynamic> toMap() => {
        "application_id": applicationId,
        "application_no": applicationNo,
        "created_at": createdAt,
        "id": id,
        "remark": remark,
        "travel_document_type": travelDocumentType.toMap(),
      };
}

class TravelDocumentType {
  dynamic description;
  DocumentCategory documentCategory;

  TravelDocumentType({
    required this.description,
    required this.documentCategory,
  });

  factory TravelDocumentType.fromMap(Map<String, dynamic> json) =>
      TravelDocumentType(
        description: json["description"],
        documentCategory: DocumentCategory.fromMap(json["document_category"]),
      );

  Map<String, dynamic> toMap() => {
        "description": description,
        "document_category": documentCategory.toMap(),
      };
}

class DocumentCategory {
  String code;
  String id;
  String name;
  List<DocumentType> documentTypes;

  DocumentCategory({
    required this.code,
    required this.id,
    required this.name,
    required this.documentTypes,
  });

  factory DocumentCategory.fromMap(Map<String, dynamic> json) =>
      DocumentCategory(
        code: json["code"],
        id: json["id"],
        name: json["name"],
        documentTypes: List<DocumentType>.from(
            json["document_types"].map((x) => DocumentType.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "id": id,
        "name": name,
        "document_types":
            List<dynamic>.from(documentTypes.map((x) => x.toMap())),
      };
}

class DocumentType {
  List<DocumentTypeApplicationDocument> applicationDocuments;

  DocumentType({
    required this.applicationDocuments,
  });

  factory DocumentType.fromMap(Map<String, dynamic> json) => DocumentType(
        applicationDocuments: List<DocumentTypeApplicationDocument>.from(
            json["application_documents"]
                .map((x) => DocumentTypeApplicationDocument.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "application_documents":
            List<dynamic>.from(applicationDocuments.map((x) => x.toMap())),
      };
}

class DocumentTypeApplicationDocument {
  Files files;
  String documentStatus;
  dynamic rejected;
  dynamic rejectionReason;
  CurrentCountry documentType;
  String id;

  DocumentTypeApplicationDocument({
    required this.files,
    required this.documentStatus,
    required this.rejected,
    required this.rejectionReason,
    required this.documentType,
    required this.id,
  });

  factory DocumentTypeApplicationDocument.fromMap(Map<String, dynamic> json) =>
      DocumentTypeApplicationDocument(
        files: Files.fromMap(json["files"]),
        documentStatus: json["document_status"],
        rejected: json["rejected"],
        rejectionReason: json["rejection_reason"],
        documentType: CurrentCountry.fromMap(json["document_type"]),
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "files": files.toMap(),
        "document_status": documentStatus,
        "rejected": rejected,
        "rejection_reason": rejectionReason,
        "document_type": documentType.toMap(),
        "id": id,
      };
}
