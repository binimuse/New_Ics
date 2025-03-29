import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_ics/app/common/loading/custom_loading_widget.dart';
import 'package:new_ics/app/data/enums.dart';
import 'package:new_ics/app/modules/new_passport/controllers/new_passport_controller.dart';
import 'package:new_ics/app/theme/app_colors.dart';
import 'package:new_ics/app/theme/app_text_styles.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

class ConfirmationPagePassport extends StatelessWidget {
  final BuildContext context;
  final NewPassportController controller;
  final VoidCallback onTap;
  final bool isFromFirstStep;

  const ConfirmationPagePassport({
    required this.context,
    required this.onTap,
    required this.controller,
    required this.isFromFirstStep,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        children: [
          _buildBackgroundLayers(),
          Padding(
            padding: const EdgeInsets.only(top: 55),
            child: Container(
              decoration: _buildMainContainerDecoration(),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildAppBar(),
                    Expanded(
                      flex: 10,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            SizedBox(height: 2.h),
                            isFromFirstStep
                                ? _buildFirstStepContent()
                                : _buildSecondStepContent(),
                          ],
                        ),
                      ),
                    ),
                    _buildStaticButton(), // Static button at the bottom
                  ],
                ),
              ),
            ),
          ),
          Obx(
            () =>
                controller.networkStatus.value == NetworkStatus.LOADING
                    ? Center(child: CustomLoadingWidget())
                    : SizedBox(),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundLayers() {
    return Column(
      children: [
        _buildBackgroundLayer(35, Colors.blueGrey.shade100),
        _buildBackgroundLayer(45, Colors.blueGrey.shade200),
      ],
    );
  }

  Widget _buildBackgroundLayer(double topPadding, Color color) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding, left: 40, right: 40),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: color,
        ),
      ),
    );
  }

  BoxDecoration _buildMainContainerDecoration() {
    return BoxDecoration(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(27),
        topLeft: Radius.circular(27),
      ),
      color: Colors.white,
    );
  }

  Widget _buildAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_rounded),
        ),
        Text('Confirm Your input'.tr, style: AppTextStyles.bodyLargeBold),
        SizedBox(width: 2.h),
      ],
    );
  }

  Widget _buildFirstStepContent() {
    return Column(
      children: [
        _buildHeadLine(number: '01', title: 'Passport Type'.tr),
        _buildTextInfo(
          'Passport Type'.tr,
          controller.selectedPassportType.value!.name!,
        ),
        SizedBox(height: 2.h),
        _buildHeadLine(number: '02', title: 'Urgency type'.tr),
        _buildTextInfo(
          'Urgency type'.tr,
          controller.selectedUrgencyType.value!.nameJson!.en.toString(),
        ),
        if (controller.selectedUrgencyType.value!.id!.toString() ==
            "e36282a6-3687-4b8c-b558-a6c51f72db13")
          _buildTextInfo('Appointment date'.tr, getDate()),
        controller.selectedUrgencyType.value!.nameJson!.en.toString() ==
                "Special"
            ? _buildForSpecial()
            : _buildForOther(),
        SizedBox(height: 2.h),
        _buildHeadLine(number: '03', title: 'Page Size and Price'.tr),
        _buildTextInfo(
          'Page Size'.tr,
          controller.pagesizeValuevalue.value!.nameJson!.en.toString(),
        ),
        _buildTextInfo('Prices'.tr, getPrices()),
      ],
    );
  }

  getPrices() {
    return controller.basePassportPrice.isNotEmpty
        ? "${controller.collactioncountry.value!.name == "Ethiopia" ? controller.basePassportPrice.first.price_etb.toString() : controller.basePassportPrice.first.price_usd.toString()} ${controller.collactioncountry.value!.name == "Ethiopia" ? "ETB" : "USD"}"
        : "";
  }

  _buildForSpecial() {
    return Column(
      children: [
        _buildTextInfo(
          'House number'.tr,
          controller.houseNumberforDeleivery.text.toString(),
        ),
        SizedBox(height: 2.h),
        _buildTextInfo(
          'Delivery address'.tr,
          controller.deliveryAddress.text.toString(),
        ),
        SizedBox(height: 2.h),
        _buildTextInfo(
          'Phone number'.tr,
          controller.countryCode.toString() +
              _formatPhoneNumber(controller.phonenumber.text),
        ),
      ],
    );
  }

  String _formatPhoneNumber(String phoneNumber) {
    if (phoneNumber.startsWith('09')) {
      return phoneNumber.substring(1);
    } else if (phoneNumber.startsWith('9')) {
      return phoneNumber;
    }
    return phoneNumber;
  }

  _buildForOther() {
    return Column(
      children: [
        _buildTextInfo(
          'Select Collection place'.tr,
          controller.collactioncountry.value!.name.toString(),
        ),
        SizedBox(height: 2.h),
        _buildTextInfo(
          'Embassies'.tr,
          controller.embassiesvalue.value!.name.toString(),
        ),
        SizedBox(height: 2.h),
        _buildTextInfo(
          'Phone number'.tr,
          controller.countryCode.toString() +
              _formatPhoneNumber(controller.phonenumber.text),
        ),
      ],
    );
  }

  getDate() {
    String dateString =
        controller.selectedDate.value!.toIso8601String().split('T').first;
    return dateString;
  }

  Widget _buildSecondStepContent() {
    return Column(
      children: [
        _buildHeadLine(number: '01', title: 'Profile'.tr),
        _showImage(controller.selectedImages.first),
        _buildUserInfo(),
        _buildHeadLine(number: '02', title: 'Address'.tr),
        _buildAddressInfo(),
        if (controller.familyModelvalue.isNotEmpty)
          _buildHeadLine(number: '03', title: 'Family Type'.tr),
        _buildFamilyType(),
      ],
    );
  }

  Widget _buildHeadLine({required String number, required String title}) {
    return Row(
      children: [
        Text(number, style: AppTextStyles.titleBold),
        const SizedBox(width: 10),
        Container(height: 25, width: 3, color: AppColors.primary),
        const SizedBox(width: 10),
        Text(
          title,
          style: AppTextStyles.titleBold.copyWith(color: AppColors.primary),
        ),
      ],
    );
  }

  Widget _buildTextInfo(String subtitle, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$subtitle:  ', style: AppTextStyles.bodyLargeBold),
          SizedBox(height: 1.h),
          Text(title, style: AppTextStyles.bodyLargeRegular),
          Divider(color: AppColors.primaryLight),
        ],
      ),
    );
  }

  Widget _showImage(dynamic path) {
    if (path is File) {
      Uri? uri = Uri.tryParse(path.path);
      return uri != null && uri.isAbsolute
          ? _buildNetworkImage(uri)
          : _buildLocalImage(path);
    } else {
      return SizedBox();
    }
  }

  Widget _buildNetworkImage(Uri uri) {
    return SizedBox(
      width: 26.w,
      height: 15.h,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: CachedNetworkImage(
          imageUrl: uri.toString(),
          fit: BoxFit.cover,
          placeholder:
              (context, url) => Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }

  Widget _buildLocalImage(File file) {
    return SizedBox(
      width: 26.w,
      height: 15.h,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.file(file, fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildUserInfo() {
    return Column(
      children: [
        _buildTextInfo("First Name".tr, controller.firstNameController.text),
        _buildTextInfo("Father Name".tr, controller.fatherNameController.text),
        _buildTextInfo(
          "Grand Father Name".tr,
          controller.grandFatherNameController.text,
        ),
        _buildTextInfo('የመጀመሪያ ስም', controller.AmfirstNameController.text),
        _buildTextInfo('የአባት ስም', controller.AmfatherNameController.text),
        _buildTextInfo('የአያት ስም', controller.AmgrandFatherNameController.text),
        _buildTextInfo(
          "Birth date".tr,
          '${controller.dayController.text}/ ${controller.monthController.text}/${controller.yearController.text}',
        ),

        _buildTextInfo(
          "Birth Country".tr,
          controller.birthCountryvalue.value!.name,
        ),
        _buildTextInfo("Birth place".tr, controller.birthplace.text),
        _buildTextInfo(
          "Gender".tr,
          controller.selectedGender.value?.name ?? "",
        ),
        _buildTextInfo(
          "Adoption ?".tr,
          controller.isAdoption.value == true ? 'yes' : 'no',
        ),
        _buildTextInfo(
          "Occupation".tr,
          controller.baseOccupationvalue.value?.name ?? "",
        ),
        _buildTextInfo(
          "Hair color".tr,
          controller.selectedHairColor.value?.name ?? "",
        ),
        _buildTextInfo(
          "eye color".tr,
          controller.selectedEyeColor.value?.name ?? "",
        ),
        _buildTextInfo(
          "Skin color".tr,
          controller.selectedEyeColor.value!.name,
        ),
        _buildTextInfo(
          "Marital Status".tr,
          controller.selectedMaritalStatus.value?.name ?? "",
        ),
        _buildTextInfo("height".tr, controller.height.text),
      ],
    );
  }

  Widget _buildAddressInfo() {
    return Column(
      children: [
        _buildTextInfo("Address Detail".tr, controller.addressController.text),
        _buildTextInfo("Phone Number".tr, controller.phonenumber.text),
      ],
    );
  }

  Widget _buildFamilyType() {
    return Column(
      children: [
        for (int i = 0; i < controller.familyModelvalue.length; i++)
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${controller.familyModelvalue[i].first_name ?? ""} : ${controller.familyModelvalue[i].father_name ?? ""}',
                    style: AppTextStyles.bodyLargeBold,
                  ),
                ],
              ),
              Divider(color: AppColors.primaryLight),
            ],
          ),
      ],
    );
  }

  Widget _buildStaticButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            controller.selectedPassportType.value = null; // Reset passport type
            Navigator.of(
              context,
            ).pop(false); // Return false if cancel is pressed
          },
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            width: 30.w,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.danger, AppColors.danger],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.all(Radius.circular(22)),
            ),
            child: Center(
              child: Text(
                "Back".tr,
                style: AppTextStyles.bodySmallRegular.copyWith(
                  color: AppColors.whiteOff,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 8.w),
        GestureDetector(
          onTap: onTap,
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            width: 30.w,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.primary],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.all(Radius.circular(22)),
            ),
            child: Center(
              child: Text(
                "Next".tr,
                style: AppTextStyles.bodySmallRegular.copyWith(
                  color: AppColors.whiteOff,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
