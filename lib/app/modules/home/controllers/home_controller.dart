import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:new_ics/app/theme/app_colors.dart';

import 'package:new_ics/app/utils/constants.dart';
import 'package:new_ics/gen/assets.gen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController with SingleGetTickerProviderMixin {
  // Variables
  List<Widget> featuredNews = [];
  List<String> images = [
    "https://images.unsplash.com/photo-1688989680825-0790dc6488fa?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80",
    "https://images.unsplash.com/photo-1664689528330-2d7ad01f8319?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=735&q=80",
    "https://images.unsplash.com/photo-1636910054073-ad228600476e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80",
    "https://images.unsplash.com/photo-1636910054073-ad228600476e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80",
  ];

  RxInt index = 0.obs;
  RxString action = "Home".obs;

  // Cards
  final List<String> svgPaths = List.filled(4, Assets.icons.passport);
  final List<String> titles = [
    'New \n Passport'.tr,
    'Renew \n Passport'.tr,
    'Passport \n Correction'.tr,
    'Lost \n Passport'.tr,
  ];

  final List<String> svgPathsOrgin = List.filled(
    4,
    Assets.icons.profileDefault,
  );
  final List<String> evisa = List.filled(5, Assets.icons.paper);
  final List<String> travel = List.filled(7, Assets.icons.paper);
  final List<String> sc = List.filled(2, Assets.icons.question);
  final List<String> re = List.filled(3, Assets.icons.memo);

  final List<String> SCtitles = ['Complaint'.tr, 'Feedback'.tr];
  final List<String> Evisatitles = [
    'E-Visa'.tr,
    'Change Visa'.tr,
    'Visa Extension'.tr,
    'Exit Visa'.tr,
  ];

  final List<Color> colortravel = [
    AppColors.success,
    AppColors.warning,
    AppColors.accent,
    AppColors.secondary,
    AppColors.primary,
    AppColors.accentGradientEnd,
    AppColors.secondaryDark,
  ];

  final List<Color> color = [
    AppColors.success,
    AppColors.warning,
    AppColors.accent,
    AppColors.secondary,
    AppColors.primary,
  ];

  // Dependencies
  late Rx<TabController> tabController;

  // late UsersByPk usersModel;
  // RxList<BaseOriginIdRenewalType> baseOriginIdRenewalType =
  //     <BaseOriginIdRenewalType>[].obs;

  // RxList<BaseResidencyRenewalType> baseResidencyRenewalType =
  //     <BaseResidencyRenewalType>[].obs;
  // RxList<BasePassportRenewalType> basePassportRenewalType =
  //     <BasePassportRenewalType>[].obs;

  var startGetUser = false.obs;
  var hasGetUser = false.obs;
  var startGettype = false.obs;
  var startTravelGettype = false.obs;

  var hasgettype = false.obs;
  var hasTravelgettype = false.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 1, vsync: this).obs;
    tabController.value.addListener(() {
      update(); // This will trigger the Obx widgets to rebuild
    });
    // getUser();
    // getRenewtype();
    // getTravelDoctype();
    // getResidentRenewtype();
    //  getRenewtypePassport();
  }

  // Future<void> getResidentRenewtype() async {
  //   startGettype(true);
  //   try {
  //     final result = await restApiService.getResidentRenewTypes();

  //     if (result != null) {
  //       baseResidencyRenewalType.value =
  //           (result as List)
  //               .map((e) => BaseResidencyRenewalType.fromMap(e))
  //               .toList();
  //     } else {
  //       hasgettype(false);
  //     }
  //   } catch (e) {
  //     hasgettype(false);
  //     print("Error fetching renewal type: $e");
  //   } finally {
  //     startGettype(false);
  //   }
  // }

  // Fetch User Data
  // Future<void> getUser() async {
  //   startGetUser(true);
  //   try {
  //     final prefs = await SharedPreferences.getInstance();
  //     final id = prefs.getString(Constants.userId);

  //     if (id != null) {
  //       final result = await restApiService.getUserById(id);
  //       startGetUser(false);

  //       if (result != null) {
  //         usersModel = UsersByPk.fromJson(result);
  //         hasGetUser(true);
  //       } else {
  //         hasGetUser(false);
  //       }
  //     }
  //   } catch (e) {
  //     hasGetUser(false);
  //     print("Error fetching user: $e");
  //   } finally {
  //     startGetUser(false);
  //   }
  // }

  // Fetch Renewal Type Data
  // Future<void> getRenewtype() async {
  //   startGettype(true);
  //   try {
  //     final result = await restApiService.getRenewTypes();

  //     if (result != null) {
  //       baseOriginIdRenewalType.value =
  //           (result as List)
  //               .map((e) => BaseOriginIdRenewalType.fromMap(e))
  //               .toList();
  //       getRenewtypePassport();
  //     } else {
  //       hasgettype(false);
  //     }
  //   } catch (e) {
  //     hasgettype(false);
  //     print("Error fetching renewal type: $e");
  //   } finally {
  //     startGettype(false);
  //   }
  // }

  // RxList<BaseTravelType> baseTravelType = <BaseTravelType>[].obs;
  // Future<void> getTravelDoctype() async {
  //   startTravelGettype(true);
  //   try {
  //     final result = await restApiService.getTravelTypes();

  //     if (result != null) {
  //       baseTravelType.value =
  //           (result as List).map((e) => BaseTravelType.fromMap(e)).toList();
  //     } else {
  //       hasTravelgettype(false);
  //     }
  //   } catch (e) {
  //     hasTravelgettype(false);
  //     print("Error fetching travel type: $e");
  //   } finally {
  //     startTravelGettype(false);
  //   }
  // }

  // Fetch Passport Renewal Type Data
  // Future<void> getRenewtypePassport() async {
  //   startGettype(true);
  //   try {
  //     final result = await restApiService.getPassportRenewTypes();

  //     if (result != null) {
  //       basePassportRenewalType.value =
  //           (result as List)
  //               .map((e) => BasePassportRenewalType.fromJson(e))
  //               .toList();
  //       hasgettype(true);
  //     } else {
  //       hasgettype(false);
  //     }
  //   } catch (e) {
  //     hasgettype(false);
  //     print("Error fetching passport renewal type: $e");
  //   } finally {
  //     startGettype(false);
  //   }
  // }
}
