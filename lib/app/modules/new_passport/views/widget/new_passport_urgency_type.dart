import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_ics/app/common/app_toasts.dart';
import 'package:new_ics/app/common/appbar/customappbar.dart';
import 'package:new_ics/app/common/button/custom_normal_button.dart';
import 'package:new_ics/app/common/loading/custom_loading_widget.dart';
import 'package:new_ics/app/data/enums.dart';
import 'package:new_ics/app/modules/new_passport/views/widget/urgency/appointemnt_class.dart';
import 'package:new_ics/app/modules/new_passport/views/widget/urgency/passport_page_size.dart';
import 'package:new_ics/app/modules/new_passport/views/widget/urgency/urgency_type_form_selection.dart';
import 'package:new_ics/app/routes/app_pages.dart';
import 'package:new_ics/app/theme/app_colors.dart';
import 'package:new_ics/app/theme/app_sizes.dart';
import 'package:new_ics/app/theme/app_text_styles.dart';

import 'package:responsive_sizer/responsive_sizer.dart';
import '../../controllers/new_passport_controller.dart';

class NewPassportUrgencyType extends StatelessWidget {
  final NewPassportController controller;
  final _formKey = GlobalKey<FormState>(); // Add a form key for validation

  NewPassportUrgencyType({required this.controller, Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Passport'.tr,
        showLeading: true,
        title2: 'urgency'.tr,
        showActions: true,
        actionIcon: Icon(Icons.close),
        routeName: () {
          Get.offAllNamed(Routes.MAIN_PAGE);
        },
      ),
      backgroundColor: AppColors.whiteOff,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _PassportContent(controller: controller, formKey: _formKey),
                ],
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
}

class _PassportContent extends StatelessWidget {
  final NewPassportController controller;
  final GlobalKey<FormState> formKey;

  const _PassportContent({
    required this.controller,
    required this.formKey,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Form(
        key: formKey, // Wrap in a Form widget for validation
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(height: 1.h),
                UrgencyTypeSelection(controller: controller),
                SizedBox(height: 2.h),
              ],
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: _NextButton(
                controller: controller,
                formKey: formKey,
              ), // Pass formKey to the button
            ),
          ],
        ),
      ),
    );
  }
}

class _NextButton extends StatelessWidget {
  final NewPassportController controller;
  final GlobalKey<FormState> formKey; // Form key to validate inputs

  const _NextButton({required this.controller, required this.formKey, Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CustomNormalButton(
        text: 'Next'.tr,
        textStyle: AppTextStyles.bodyLargeBold.copyWith(
          color: AppColors.whiteOff,
        ),
        textcolor: AppColors.whiteOff,
        buttoncolor:
            controller.selectedUrgencyType.value == null
                ? AppColors.grayLight
                : AppColors.primary,
        borderRadius: AppSizes.radius_8,
        padding: EdgeInsets.symmetric(
          vertical: AppSizes.mp_v_2,
          horizontal: AppSizes.mp_w_6,
        ),
        onPressed: _handleNextButtonPress,
      ),
    );
  }

  void _handleNextButtonPress() {
    // Validate form inputs before navigating
    if (formKey.currentState?.validate() ?? false) {
      if (controller.selectedUrgencyType.value == null) {
        AppToasts.showError("Error, Please select Service type".tr);
        return;
      }

      // Check if specific fields are not selected and show appropriate messages
      if (controller.collactioncountry.value == null) {
        AppToasts.showError("Please select your collection country".tr);
        return;
      }

      if (controller.embassiesvalue.value == null) {
        AppToasts.showError("Please select an embassy".tr);
        return;
      }

      if (!controller.isPhoneValid.value) {
        AppToasts.showError("Phone number is not valid".tr);
        return;
      }

      // Navigate based on urgency type selection
      if (_isUrgentSelectionValid()) {
        Get.to(() => PassportPageSize(controller: controller));
      } else if (_isOrdinarySelectionValid()) {
        Get.to(() => AppointmentStep());
      } else if (_isSpecialSelectionValid()) {
        Get.to(() => PassportPageSize(controller: controller));
      } else {
        _showSpecificFieldErrors();
      }
    } else {
      AppToasts.showError("Please fill all required fields".tr);
    }
  }

  void _showSpecificFieldErrors() {
    if (controller.addressController.text.isEmpty) {
      AppToasts.showError("Address is required".tr);
    }
    if (controller.collactioncountry.value == null) {
      AppToasts.showError("Collection country is required".tr);
    }
    if (controller.embassiesvalue.value == null) {
      AppToasts.showError("Embassy selection is required".tr);
    }
    if (!controller.isPhoneValid.value) {
      AppToasts.showError("Phone number is not valid".tr);
    }

    if (controller.selectedUrgencyType.value!.nameJson!.en == 'Special') {
      if (controller.houseNumberforDeleivery.text.isEmpty) {
        AppToasts.showError("House number for delivery is required".tr);
      }
      if (controller.deliveryAddress.text.isEmpty) {
        AppToasts.showError("Delivery address is required".tr);
      }
    }
  }

  bool _isUrgentSelectionValid() {
    // Check if selected urgency type is either 'Urgent 5 days' or 'Urgent 2 days'
    bool isUrgentType =
        controller.selectedUrgencyType.value!.nameJson!.en == 'Urgent 5 days' ||
        controller.selectedUrgencyType.value!.nameJson!.en == 'Urgent 2 days' ||
        controller.selectedUrgencyType.value!.nameJson!.en == 'Urgent 15 days';

    // Validate if required fields for Urgent type are filled
    return isUrgentType && _isBasicDetailsFilled();
  }

  bool _isOrdinarySelectionValid() {
    return controller.selectedUrgencyType.value!.id ==
            'e36282a6-3687-4b8c-b558-a6c51f72db13' ||
        controller.selectedUrgencyType.value!.id ==
                '23d3bc45-1e42-420d-b34c-878a19fc459b' &&
            _isBasicDetailsFilled();
  }

  bool _isSpecialSelectionValid() {
    return controller.selectedUrgencyType.value!.nameJson!.en == 'Special' &&
        controller.houseNumberforDeleivery.text.isNotEmpty &&
        controller.collactioncountry.value != null &&
        controller.deliveryAddress.text.isNotEmpty &&
        controller.phonenumber.text.isNotEmpty;
  }

  bool _isBasicDetailsFilled() {
    return controller.addressController.text.isNotEmpty &&
        controller.collactioncountry.value != null &&
        controller.embassiesvalue.value != null &&
        controller.phonenumber.text.isNotEmpty != null;
  }
}
