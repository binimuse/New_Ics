import 'dart:developer';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:new_ics/app/common/app_toasts.dart';
import 'package:http_parser/http_parser.dart';
import 'package:new_ics/app/common/model/basemodel.dart';
import 'package:new_ics/app/data/enums.dart';
import 'package:new_ics/app/data/models/passport/base_country.dart';
import 'package:new_ics/app/data/models/passport/base_document_type.dart';
import 'package:new_ics/app/data/models/passport/base_embassiy.dart';
import 'package:new_ics/app/data/models/passport/base_occupation.dart';
import 'package:new_ics/app/data/models/passport/base_regions.dart';
import 'package:new_ics/app/data/models/passport/passport_page_price.dart';
import 'package:new_ics/app/data/models/passport/passport_page_size.dart';
import 'package:new_ics/app/data/models/passport/passport_responce.dart';
import 'package:new_ics/app/data/models/passport/passport_type.dart';
import 'package:new_ics/app/data/models/passport/passport_urgency_type.dart';
import 'package:new_ics/app/data/services/module_passport_service.dart';
import 'package:new_ics/app/routes/app_pages.dart';
import 'package:new_ics/app/utils/dio_util.dart';
import 'package:new_ics/app/utils/validator_util.dart';

import 'package:file_picker/file_picker.dart';

import 'package:dio/dio.dart';

class NewPassportController extends GetxController {
  Rx<NetworkStatus> networkStatus = Rx(NetworkStatus.IDLE);
  //form contollers
  final TextEditingController AmfatherNameController = TextEditingController();
  final TextEditingController AmfirstNameController = TextEditingController();
  final TextEditingController AmgrandFatherNameController =
      TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController dateofbirth = TextEditingController();
  final TextEditingController dayController = TextEditingController();
  final TextEditingController fatherNameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController birthplace = TextEditingController();
  final TextEditingController grandFatherNameController =
      TextEditingController();
  final TextEditingController height = TextEditingController();
  final TextEditingController familyfirstNameController =
      TextEditingController();
  final TextEditingController familyFatherNameController =
      TextEditingController();
  final TextEditingController phonenumber = TextEditingController();
  final TextEditingController reasonController = TextEditingController();
  final TextEditingController monthController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  //for deleivery

  final TextEditingController houseNumberforDeleivery = TextEditingController();
  final TextEditingController deliveryAddress = TextEditingController();

  // Form Key
  final newPassportformKey = GlobalKey<FormBuilderState>();
  final urgencyFormKey = GlobalKey<FormBuilderState>();
  List<DateTime> occupiedDates = [];
  // Focus Nodes
  final phoneFocusNode = FocusNode();
  // Variables

  List<CommonModel> countries = [];
  List<CommonModel> base_regions = [];

  // List<PassportDocuments> documents = [];

  List<CommonModel> occupations = [];
  List<BaseCountry> familytype = [];

  late TextEditingController emailController;
  // List<DateTime> occupiedDates = [];
  // List<DocPathModel> docList = [];
  var countryCode = "+251";
  var newApplicationId;
  Rxn<DateTime> selectedDate = Rxn<DateTime>();
  Rxn<DateTime> selectedDateTime = Rxn<DateTime>();
  late TabController tabController;
  var displayedPrice = ''.obs;
  var isEmailValid = false.obs;
  final emailFocusNode = FocusNode();
  @override
  void onInit() {
    emailController = TextEditingController();
    getPassportType();
    getBaseCountry();
    getPassportPageSize();
    getoccupation();
    getdocumnatType();
    super.onInit();
  }

  //base passport type
  Rxn<PassportTypeResponse> selectedPassportType = Rxn<PassportTypeResponse>();
  RxList<PassportTypeResponse> passportTypeResponse =
      RxList<PassportTypeResponse>([]);
  void setPassportType(PassportTypeResponse passportType) {
    print("Passport type selected: ${passportType.id}");
    selectedPassportType.value = passportType;
  }

  RxList<BasePassportPageSize> basePassportPageSize =
      RxList<BasePassportPageSize>([]);

  RxList<BaseOccupation> baseOccupation = RxList<BaseOccupation>([]);
  RxList<BasedocumentCategoryType> basedocumentCategoryType =
      RxList<BasedocumentCategoryType>([]);
  Rxn<BasePassportPageSize> pagesizeValuevalue = Rxn<BasePassportPageSize>();

  RxList<BasePassportUrgencyType> basePassportUrgencyType =
      RxList<BasePassportUrgencyType>([]);

  RxList<BaseCountry> baseCountry = RxList<BaseCountry>([]);
  RxList<BaseEmbassies> baseEmbassies = RxList<BaseEmbassies>([]);
  RxList<BaseRegionResponce> baseRegionResponce = RxList<BaseRegionResponce>(
    [],
  );

  RxList<BasePassportPrice> basePassportPrice = RxList<BasePassportPrice>([]);
  Rxn<BasePassportUrgencyType> selectedUrgencyType =
      Rxn<BasePassportUrgencyType>();

  RxList<BasePassportUrgencyType> filteredUrgencyTypes =
      List<BasePassportUrgencyType>.of([]).obs;

  Rxn<Basemodel> baseData = Rxn<Basemodel>();
  //Rxn<BookedDate> bookedDate = Rxn<BookedDate>();
  Rxn<BaseCountry> birthCountryvalue = Rxn<BaseCountry>();
  Rxn<CommonModel> natinalityvalue = Rxn<CommonModel>();
  Rxn<BaseCountry> familynatinalityvalue = Rxn<BaseCountry>();
  Rxn<BaseEmbassies> embassiesvalue = Rxn<BaseEmbassies>();

  Rxn<Gender> selectedGender = Rxn<Gender>();
  Rxn<MaritalStatus> selectedMaritalStatus = Rxn<MaritalStatus>();
  Rxn<SkinColor> selectedSkinColor = Rxn<SkinColor>();
  Rxn<EyeColor> selectedEyeColor = Rxn<EyeColor>();
  Rxn<HairColor> selectedHairColor = Rxn<HairColor>();
  Rxn<BaseOccupation> baseOccupationvalue = Rxn<BaseOccupation>();

  Rxn<BaseOccupation> familytypevalue = Rxn<BaseOccupation>();

  Rxn<CommonModel> regionsvalue = Rxn<CommonModel>();
  Rxn<BaseCountry> collactioncountry = Rxn<BaseCountry>();
  Rxn<BaseCountry> currentcountryvalue = Rxn<BaseCountry>();
  // Rxn<BasePassportPageSize> pagesizeValuevalue = Rxn<BasePassportPageSize>();
  // Rxn<GetUrlModel> getUrlModel = Rxn<GetUrlModel>();

  RxBool isPhoneValid = false.obs;
  RxBool isfeched = false.obs;
  RxBool isAdoption = false.obs;
  RxBool showAdoption = false.obs;
  RxBool isSend = false.obs;
  RxBool isSendDocSuccess = false.obs;
  RxBool isUpdateSuccess = false.obs;
  RxBool isDeleteDocSuccess = false.obs;
  RxBool isfechediCitizens = false.obs;
  RxBool isfechedEmbassies = false.obs;
  RxBool isfechedregions = false.obs;
  RxBool setFetchedStatus = false.obs;
  RxBool isDeliveryRequired = false.obs;

  //form
  RxInt currentStep = 0.obs;
  RxList<File> selectedImages = <File>[].obs;
  List<PassportDocuments> documents = [];
  RxList<FamilyModel> familyModelvalue = RxList<FamilyModel>();
  RxList<String> photoPath = <String>[].obs;
  List<String> contentTexts = [
    'Size of the image/document should be less than 2MB.'.tr,
    'Photo and Passport Copy should be only in Image file type of JPEG, JPG, PNG format.'
        .tr,
    'Allowed Images/documents file type extensions are JPEG, JPG, PNG and PDF format only.'
        .tr,
    'An image/document with blurred or unclean background is not acceptable.'
        .tr,
    'Please use the below Screenshot for Photograph Tips.'.tr,
  ];
  List<DocPathModel> docList = [];
  bool validateEmail() {
    final email = emailController.text;
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(pattern);
    if (regex.hasMatch(email)) {
      isEmailValid(true);
      return true;
    } else {
      isEmailValid(false);
      return false;
    }
  }

  void getdocumnatType() async {
    networkStatus.value = NetworkStatus.LOADING;

    try {
      List<BasedocumentCategoryType> response = await PassportService(
        DioUtil().getDio(useAccessToken: true),
      ).getdocumenttype("NEW_PASSPORT");

      basedocumentCategoryType.value =
          response.where((type) => type.draft == false).toList();

      for (var documentType in basedocumentCategoryType) {
        documents.add(
          PassportDocuments(documentTypeId: documentType.id, files: []),
        );
      }
      // print("sdfsf ${documents.length}");

      networkStatus.value = NetworkStatus.SUCCESS;
    } catch (e, s) {
      print(e);
      print(s);
      networkStatus.value = NetworkStatus.ERROR;
      ValidatorUtil.handleError(e);
    }
  }

  void getoccupation() async {
    networkStatus.value = NetworkStatus.LOADING;

    try {
      List<BaseOccupation> response =
          await PassportService(
            DioUtil().getDio(useAccessToken: true),
          ).getoccupation();
      //ToDO: change this to  response.where((type) => type.draft == false).toList();
      baseOccupation.value =
          response.where((type) => type.draft != false).toList();

      networkStatus.value = NetworkStatus.SUCCESS;
    } catch (e, s) {
      print(e);
      print(s);
      networkStatus.value = NetworkStatus.ERROR;
      ValidatorUtil.handleError(e);
    }
  }

  getEmbassies(String countryid) async {
    networkStatus.value = NetworkStatus.LOADING;

    try {
      List<BaseEmbassies> response = await PassportService(
        DioUtil().getDio(useAccessToken: true),
      ).getembassy(countryid);

      baseEmbassies.value =
          response.where((type) => type.draft == false).toList();

      networkStatus.value = NetworkStatus.SUCCESS;
      isfechedEmbassies.value = true;
    } catch (e, s) {
      print(e);
      print(s);
      isfechedEmbassies.value = false;
      networkStatus.value = NetworkStatus.ERROR;
      ValidatorUtil.handleError(e);
    }
  }

  void getBaseCountry() async {
    networkStatus.value = NetworkStatus.LOADING;

    try {
      List<BaseCountry> response =
          await PassportService(
            DioUtil().getDio(useAccessToken: true),
          ).getCountry();

      baseCountry.value =
          response.where((type) => type.draft == false).toList();

      networkStatus.value = NetworkStatus.SUCCESS;
    } catch (e, s) {
      print(e);
      print(s);
      networkStatus.value = NetworkStatus.ERROR;
      ValidatorUtil.handleError(e);
    }
  }

  getPassportUrgencyType() async {
    networkStatus.value = NetworkStatus.LOADING;

    try {
      List<BasePassportUrgencyType> response =
          await PassportService(
            DioUtil().getDio(useAccessToken: true),
          ).getPassporturgencylevel();
      //ToDO: change this to  response.where((type) => type.draft == false).toList();
      basePassportUrgencyType.value =
          response.where((type) => type.draft != false).toList();

      filterUrgencyTypes();

      networkStatus.value = NetworkStatus.SUCCESS;
    } catch (e, s) {
      print(e);
      print(s);
      networkStatus.value = NetworkStatus.ERROR;
      ValidatorUtil.handleError(e);
    }
  }

  void getPassportPrice() async {
    networkStatus.value = NetworkStatus.LOADING;

    try {
      List<BasePassportPrice> response =
          await PassportService(
            DioUtil().getDio(useAccessToken: true),
          ).getPassportPrice();

      basePassportPrice.value =
          response.where((type) => type.draft == false).toList();

      networkStatus.value = NetworkStatus.SUCCESS;
      updateDisplayedPrice();
    } catch (e, s) {
      print(e);
      print(s);
      networkStatus.value = NetworkStatus.ERROR;
      ValidatorUtil.handleError(e);
    }
  }

  void updateDisplayedPrice() {
    if (collactioncountry.value!.name == "Ethiopia") {
      displayedPrice.value = basePassportPrice.first.price_etb.toString();
    } else {
      displayedPrice.value = basePassportPrice.first.price_usd.toString();
    }
  }

  void setUrgencyType(BasePassportUrgencyType urgencyType) {
    selectedUrgencyType.value = urgencyType;
  }

  void filterUrgencyTypes() {
    if (collactioncountry.value != null) {
      if (collactioncountry.value!.name.toLowerCase() == "ethiopia") {
        filteredUrgencyTypes.value =
            basePassportUrgencyType
                .where((type) => type.for_abroad == false)
                .toList();
      } else {
        filteredUrgencyTypes.value =
            basePassportUrgencyType
                .where((type) => type.for_abroad == true)
                .toList();
      }
    } else {
      filteredUrgencyTypes.clear();
    }
  }

  void getPassportPageSize() async {
    networkStatus.value = NetworkStatus.LOADING;

    try {
      List<BasePassportPageSize> response =
          await PassportService(
            DioUtil().getDio(useAccessToken: true),
          ).getPassportPageSize();
      //ToDO: change this to  response.where((type) => type.draft == false).toList();
      basePassportPageSize.value =
          response.where((type) => type.draft != false).toList();

      networkStatus.value = NetworkStatus.SUCCESS;
    } catch (e, s) {
      print(e);
      print(s);
      networkStatus.value = NetworkStatus.ERROR;
      ValidatorUtil.handleError(e);
    }
  }

  void getPassportType() async {
    networkStatus.value = NetworkStatus.LOADING;

    try {
      List<PassportTypeResponse> response =
          await PassportService(
            DioUtil().getDio(useAccessToken: true),
          ).getPassportTypeResponse();

      passportTypeResponse.value =
          response.where((type) => type.draft == false).toList();

      networkStatus.value = NetworkStatus.SUCCESS;
    } catch (e, s) {
      print(e);
      print(s);
      networkStatus.value = NetworkStatus.ERROR;
      ValidatorUtil.handleError(e);
    }
  }

  // Dummy data for instructions
  RxList<BaseInstruction> baseInstruction =
      <BaseInstruction>[
        BaseInstruction(
          title: 'Amharic Keyboard',
          description: 'Amharic Keyboard',
        ),
        BaseInstruction(
          title: 'Document in PDF Format',
          description: 'Document in PDF Format',
        ),
      ].obs;

  // Methods to handle terms
  RxList<bool> termsChecked = <bool>[false, false].obs;

  bool isTermChecked(int index) {
    return termsChecked[index];
  }

  void toggleTerm(int index) {
    termsChecked[index] = !termsChecked[index];
  }

  bool areAllTermsSelected() {
    return termsChecked.every((element) => element);
  }

  void addtoDocumants(BasedocumentCategoryType pas) {
    print(documents.length);
    basedocumentCategoryType.add(pas);
  }

  void removeFromDocumants(BasedocumentCategoryType pas) {
    basedocumentCategoryType.removeWhere((element) => element.id == pas.id);
  }

  RxList<PlatformFile> selectedFile = <PlatformFile>[].obs;
  void sendPassportData() async {
    networkStatus.value = NetworkStatus.LOADING;

    try {
      // Prepare the payload
      Map<String, dynamic> payload = _preparePassportPayload();

      log("Payload: $payload");

      // Send the passport data
      final PassportResponce response = await PassportService(
        DioUtil().getDio(useAccessToken: true),
      ).sendPassport(payload);

      // Handle successful response

      sendDocuments(response.data.id);
    } catch (e, s) {
      _handleError(e, s);
    }
  }

  Map<String, dynamic> _preparePassportPayload() {
    // Format the date of birth
    DateTime dateOfBirth = DateTime(
      int.parse(yearController.text),
      int.parse(monthController.text),
      int.parse(dayController.text),
    );
    String formattedDateOfBirth = DateFormat(
      "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'",
    ).format(dateOfBirth);

    // Format the validation schedule date
    DateTime parsedDate = DateTime.parse(selectedDateTime.value.toString());
    String formattedselectedDateTime = DateFormat(
      "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'",
    ).format(parsedDate.toUtc());

    // Return the payload
    return {
      "first_name": firstNameController.text.trim(),
      "father_name": fatherNameController.text.trim(),
      "grand_father_name": grandFatherNameController.text.trim(),
      "first_name_json": firstnameToJson(),
      "father_name_json": fathernameToJson(),
      "grand_father_name_json": gfathernameToJson(),
      "date_of_birth": formattedDateOfBirth,
      "birth_place": birthplace.text.trim(),
      "birth_country_id": birthCountryvalue.value?.id ?? "",
      "marital_status": selectedMaritalStatus.value?.name ?? "",
      "hair_color": selectedHairColor.value?.name ?? "",
      "gender": selectedGender.value?.name ?? "",
      "skin_color": selectedSkinColor.value?.name ?? "",
      "eye_color": selectedEyeColor.value?.name ?? "",
      "height": height.text.isEmpty ? null : height.text.trim(),
      "occupation_id": baseOccupationvalue.value?.id ?? "",
      "living_address": addressController.text.trim(),
      "living_country_id": currentcountryvalue.value?.id ?? "",
      "current_country_id": currentcountryvalue.value?.id ?? "",
      "phone_number": countryCode + phonenumber.text.trim(),
      "branch_id": embassiesvalue.value?.id ?? "",
      "service_urgency_level_id": selectedUrgencyType.value?.id ?? "",
      "passport_page_size_id": pagesizeValuevalue.value?.id ?? "",
      "passport_type_id": selectedPassportType.value?.id ?? "",
      "passport_price_id": basePassportPrice.first.id,
      "validation_schedule_date": formattedselectedDateTime,
    };
  }

  void sendDocuments(String newPassportApplicationId) async {
    if (documents.isEmpty) {
      print("No documents to send.");
      return;
    }

    networkStatus.value = NetworkStatus.LOADING;

    try {
      for (var document in documents) {
        for (var file in document.files) {
          await _uploadDocument(
            newPassportApplicationId,
            document.documentTypeId,
            file,
          );
        }
      }

      makeSubmitetdTrue(newPassportApplicationId);
    } catch (e, s) {
      _handleError(e, s);
    }
  }

  Future<void> _uploadDocument(
    String applicationId,
    String documentTypeId,
    PlatformFile file,
  ) async {
    File localFile = File(file.path!);

    String fileExtension = localFile.path.split('.').last.toLowerCase();
    String mimeType = _getMimeType(fileExtension);

    MultipartFile multipartFile = await MultipartFile.fromFile(
      localFile.path,
      contentType: MediaType.parse(mimeType),
    );

    FormData formData = FormData.fromMap({
      'new_passport_application_id': applicationId,
      'document_category_type_id': documentTypeId,
      'file': multipartFile,
    });

    await PassportService(
      DioUtil().getDio(useAccessToken: true),
    ).sendPassportDoc(formData: formData);

    print("Document sent successfully: ${file.name}");
  }

  String _getMimeType(String fileExtension) {
    if (fileExtension == 'pdf') {
      return 'application/pdf';
    } else if (['jpeg', 'jpg', 'png'].contains(fileExtension)) {
      return 'image/${fileExtension == 'jpg' ? 'jpeg' : fileExtension}';
    } else {
      throw Exception("Unsupported file type");
    }
  }

  void makeSubmitetdTrue(String newPassportApplicationId) async {
    networkStatus.value = NetworkStatus.LOADING;

    try {
      await PassportService(
        DioUtil().getDio(useAccessToken: true),
      ).makeSubmitTrue(newPassportApplicationId);

      networkStatus.value = NetworkStatus.SUCCESS;
      AppToasts.showSuccess("Passport data submitted successfully.".tr);
      Get.offNamedUntil(Routes.MAIN_PAGE, (route) => true);
    } catch (e, s) {
      _handleError(e, s);
    }
  }

  void _handleError(dynamic e, StackTrace s) {
    print(e);
    print(s);
    networkStatus.value = NetworkStatus.ERROR;
    ValidatorUtil.handleError(e);
  }
  // Future<String> uploadPhoto(String filePath) async {
  //   try {
  //     File file = File(filePath);
  //     String fileName = file.path.split('/').last;

  //     FormData formData = FormData.fromMap({
  //       'file': await MultipartFile.fromFile(file.path, filename: fileName),
  //     });

  //     final response = await PassportService(
  //       DioUtil().getDio(useAccessToken: true),
  //     ).uploadPhoto(formData: formData);

  //     if (response != null && response['url'] != null) {
  //       return response['url']; // Return the uploaded photo URL
  //     } else {
  //       throw Exception("Failed to upload photo.");
  //     }
  //   } catch (e) {
  //     print("Photo upload error: $e");
  //     throw Exception("Photo upload failed.");
  //   }
  // }

  Map<String, dynamic> firstnameToJson() {
    return {"en": firstNameController.text, "am": AmfirstNameController.text};
  }

  Map<String, dynamic> gfathernameToJson() {
    return {
      "en": grandFatherNameController.text,
      "am": AmgrandFatherNameController.text,
    };
  }

  Map<String, dynamic> fathernameToJson() {
    return {"en": fatherNameController.text, "am": AmfatherNameController.text};
  }
}

class BaseInstruction {
  final String title;
  final String description;

  BaseInstruction({required this.title, required this.description});
}

class PassportDocuments {
  final documentTypeId;
  final List<PlatformFile> files;

  const PassportDocuments({required this.documentTypeId, required this.files});
}

enum Gender { MALE, FEMALE }

enum MaritalStatus { SINGLE, MARRIED, DIVORCED, WIDOWED }

enum SkinColor { FAIR, LIGHT, MEDIUM, DARK }

enum EyeColor { BLACK, BROWN, BLUE, GREEN, HAZEL }

enum HairColor { BLACK, BROWN, BLONDE, RED, GRAY, WHITE }
