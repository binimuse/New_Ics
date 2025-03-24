import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:new_ics/app/common/model/basemodel.dart';
import 'package:new_ics/app/data/enums.dart';
import 'package:new_ics/app/data/models/passport/base_country.dart';
import 'package:new_ics/app/data/models/passport/base_embassiy.dart';
import 'package:new_ics/app/data/models/passport/base_regions.dart';
import 'package:new_ics/app/data/models/passport/passport_page_price.dart';
import 'package:new_ics/app/data/models/passport/passport_page_size.dart';
import 'package:new_ics/app/data/models/passport/passport_type.dart';
import 'package:new_ics/app/data/models/passport/passport_urgency_type.dart';
import 'package:new_ics/app/data/services/module_passport_service.dart';
import 'package:new_ics/app/utils/dio_util.dart';
import 'package:new_ics/app/utils/validator_util.dart';

import 'package:file_picker/file_picker.dart';

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
  List<String> SkinColor = ['Black', 'Brown', 'Blue', 'Other'];
  List<CommonModel> countries = [];
  List<CommonModel> base_regions = [];
  List<CommonModel> base_document_types = [];
  // List<PassportDocuments> documents = [];
  List<CommonModel> martial = [];
  List<CommonModel> gender = [];
  List<CommonModel> occupations = [];
  List<CommonModel> familytype = [];

  List<CommonModel> natinality = [];
  List<CommonModel> haircolor = [];
  List<CommonModel> eyecolor = [];

  // List<DateTime> occupiedDates = [];
  // List<DocPathModel> docList = [];
  var countryCode = "+251";
  var newApplicationId;
  Rxn<DateTime> selectedDate = Rxn<DateTime>();
  Rxn<DateTime> selectedDateTime = Rxn<DateTime>();
  late TabController tabController;
  var displayedPrice = ''.obs;
  @override
  void onInit() {
    getPassportType();
    getBaseCountry();
    getPassportPageSize();
    super.onInit();
  }

  //base passport type
  Rxn<PassportTypeResponse> selectedPassportType = Rxn<PassportTypeResponse>();
  RxList<PassportTypeResponse> passportTypeResponse =
      RxList<PassportTypeResponse>([]);
  void setPassportType(PassportTypeResponse passportType) {
    selectedPassportType.value = passportType;
  }

  RxList<BasePassportPageSize> basePassportPageSize =
      RxList<BasePassportPageSize>([]);
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
    } catch (e) {
      isfechedEmbassies.value = false;
      print(e);
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
    } catch (e) {
      print(e);
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
    } catch (e) {
      print(e);
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
    } catch (e) {
      print(e);
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

  // void getRegion(String country_id) async {
  //   networkStatus.value = NetworkStatus.LOADING;

  //   try {
  //     List<BaseRegionResponce> response = await PassportService(
  //       DioUtil().getDio(useAccessToken: true),
  //     ).getregions(country_id);

  //     baseRegionResponce.value =
  //         response.where((type) => type.draft == false).toList();

  //     networkStatus.value = NetworkStatus.SUCCESS;
  //   } catch (e) {
  //     print(e);
  //     networkStatus.value = NetworkStatus.ERROR;
  //     ValidatorUtil.handleError(e);
  //   }
  // }

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
    } catch (e) {
      print(e);
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
    } catch (e) {
      print(e);
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

  //urgency
  // Rxn<BaseServiceUrgencyLevel> selectedUrgencyType =
  //     Rxn<BaseServiceUrgencyLevel>(); // Initially null

  Rxn<Basemodel> baseData = Rxn<Basemodel>();
  //Rxn<BookedDate> bookedDate = Rxn<BookedDate>();
  Rxn<BaseCountry> birthCountryvalue = Rxn<BaseCountry>();
  Rxn<CommonModel> natinalityvalue = Rxn<CommonModel>();
  Rxn<CommonModel> familynatinalityvalue = Rxn<CommonModel>();
  Rxn<BaseEmbassies> embassiesvalue = Rxn<BaseEmbassies>();
  Rxn<CommonModel> eyecolorvalue = Rxn<CommonModel>();
  Rxn<CommonModel> haircolorvalue = Rxn<CommonModel>();
  Rxn<CommonModel> maritalstatusvalue = Rxn<CommonModel>();
  Rxn<CommonModel> gendervalue = Rxn<CommonModel>();
  Rxn<CommonModel> occupationvalue = Rxn<CommonModel>();
  Rxn<CommonModel> familytypevalue = Rxn<CommonModel>();

  Rxn<CommonModel> regionsvalue = Rxn<CommonModel>();
  Rxn<BaseCountry> collactioncountry = Rxn<BaseCountry>();
  // Rxn<BasePassportPageSize> pagesizeValuevalue = Rxn<BasePassportPageSize>();
  // Rxn<GetUrlModel> getUrlModel = Rxn<GetUrlModel>();
  RxString skincolorvalue = ''.obs;
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
  void addtoDocumants(CommonModel pas) {
    print(documents.length);
    base_document_types.add(pas);
  }

  void removeFromDocumants(CommonModel pas) {
    base_document_types.removeWhere((element) => element.id == pas.id);
  }

  void sendPassportData() {}

  void deleteDoc(String? id) {}
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
