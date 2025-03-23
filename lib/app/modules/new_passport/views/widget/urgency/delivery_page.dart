import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_ics/app/common/appbar/customappbar.dart';
import 'package:new_ics/app/common/button/custom_normal_button.dart';
import 'package:new_ics/app/common/forms/phone_number_input.dart';
import 'package:new_ics/app/common/forms/text_input_with_builder.dart';
import 'package:new_ics/app/common/loading/custom_loading_widget.dart';
import 'package:new_ics/app/data/enums.dart';
import 'package:new_ics/app/modules/new_passport/controllers/new_passport_controller.dart';
import 'package:new_ics/app/modules/new_passport/views/widget/urgency/appointemnt_class.dart';
import 'package:new_ics/app/routes/app_pages.dart';
import 'package:new_ics/app/theme/app_colors.dart';
import 'package:new_ics/app/theme/app_sizes.dart';
import 'package:new_ics/app/theme/app_text_styles.dart';
import 'package:form_validator/form_validator.dart';
import 'package:new_ics/app/utils/validator_util.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DeliveryPage extends StatelessWidget {
  final NewPassportController controller;

  const DeliveryPage({required this.controller, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        title: 'Delivery'.tr,
        title2: "Detail".tr,
        showLeading: true,
        showActions: true,
        actionIcon: Icon(Icons.close),
        routeName: () {
          Get.offAllNamed(Routes.MAIN_PAGE);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(
                        Icons.info,
                        size: 19.2,
                        color: AppColors.primary,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        //    Get.toNamed(Routes.HOW_TO_CREATE);
                      },
                      child: SizedBox(
                        width: 70.w,
                        child: Text(
                          'Note info:'.tr,
                          style: AppTextStyles.bodySmallUnderlineRegular
                              .copyWith(fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),

                Text(
                  'If scheduling a delivery in the Fall you must enter your delivery information by July 20th in order to prevent any complications and/or additional fees associated with your delivery.'
                      .tr,
                  style: AppTextStyles.bodySmallRegular.copyWith(
                    fontSize: AppSizes.font_12,
                  ),
                ),
                SizedBox(height: 2.h),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Enter Your Delivery Information'.tr,
                    style: AppTextStyles.bodyLargeUnderlineRegular.copyWith(
                      fontSize: AppSizes.font_14,
                      color: AppColors.grayDark,
                    ),
                    maxLines: 2,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildTextInput(
                    controller.houseNumberforDeleivery,
                    'House Number'.tr,
                    true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildTextInput(
                    controller.deliveryAddress,
                    'Delivery Address',
                    true,
                  ),
                ),

                _buildPhoneInput(),
              ],
            ),
            Spacer(),
            _buildNextButton(),
            Obx(
              () =>
                  controller.networkStatus.value == NetworkStatus.LOADING
                      ? Center(child: CustomLoadingWidget())
                      : SizedBox(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneInput() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 5, child: _buildCountryCode()),
        SizedBox(width: AppSizes.mp_w_4),
        Expanded(flex: 10, child: _buildPhoneNumber()),
      ],
    );
  }

  Widget _buildCountryCode() {
    return CountryCodePicker(
      flagDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.primaryDark,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(3, 3),
          ),
        ],
      ),
      onChanged: (element) {
        debugPrint(element.dialCode);
        controller.countryCode = element.dialCode.toString();
      },
      textStyle: AppTextStyles.captionBold,
      initialSelection: 'et',
      padding: EdgeInsets.symmetric(vertical: 20),
    );
  }

  Widget _buildPhoneNumber() {
    return PhoneNumberInput(
      isMandatory: true,
      hint: 'Phone numbers'.tr,
      labelText: "Phone number".tr,
      focusNode: controller.phoneFocusNode,
      autofocus: false,
      controller: controller.phonenumber,
      onChanged: (value) {
        bool isValid = ValidatorUtil.validatPhone(value);
        controller.isPhoneValid.value = isValid;
      },
      validator: (value) {
        if (!ValidatorUtil.validatPhone(value!)) {
          return 'Invalid phone number'.tr;
        }

        return null;
      },
    );
  }

  Widget _buildTextInput(
    TextEditingController controller,
    String label,
    bool isMandatory,
  ) {
    return TextFormBuilder(
      isMandatory: isMandatory,
      controller: controller,
      validator: ValidationBuilder().required('${label} required'.tr).build(),
      hint: label.tr,
      maxlength: 90,
      labelText: label.tr,
      showClearButton: false,
      autoFocus: false,
      inputFormatters: isMandatory ? [] : [],
    );
  }

  Widget _buildNextButton() {
    return Positioned(
      bottom: 16.0,
      left: 16.0,
      right: 16.0,
      child: Obx(() {
        final isHouseNumberFilled =
            controller.houseNumberforDeleivery.text.isNotEmpty;
        final isDeliveryAddressFilled =
            controller.deliveryAddress.text.isNotEmpty;
        final isPhoneValid = controller.isPhoneValid.value;
        final isButtonEnabled =
            isHouseNumberFilled && isDeliveryAddressFilled && isPhoneValid;

        return CustomNormalButton(
          text: 'Next'.tr,
          textStyle: AppTextStyles.bodyLargeBold.copyWith(
            color: isButtonEnabled ? AppColors.whiteOff : AppColors.whiteOff,
          ),
          textcolor: isButtonEnabled ? AppColors.whiteOff : AppColors.grayLight,
          buttoncolor:
              isButtonEnabled
                  ? AppColors.primary
                  : AppColors.grayLight.withOpacity(0.5),
          borderRadius: AppSizes.radius_12,
          padding: EdgeInsets.symmetric(
            vertical: AppSizes.mp_v_2,
            horizontal: AppSizes.mp_w_6,
          ),
          onPressed: () {
            if (!isButtonEnabled) return;
            Get.to(() => AppointmentStep());
            // Navigate to the next page
            // Get.to(() => InstructionCard(controller: controller));
            // Get.to(ConfirmationPagePassport(
            //   context: context,
            //   controller: controller,
            //   onTap: () {
            //     Get.to(() => ProfileView());
            //   },
            //   isFromFirstStep: true,
            // ));
          },
        );
      }),
    );
  }
}
