// ignore_for_file: must_be_immutable

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:new_ics/app/common/dropdown/common_search_drop_down.dart';
import 'package:new_ics/app/common/forms/phone_number_input.dart';
import 'package:new_ics/app/common/forms/reusableDropdown.dart';
import 'package:new_ics/app/common/forms/text_input_signup.dart';
import 'package:new_ics/app/common/forms/text_input_with_builder.dart';
import 'package:new_ics/app/common/model/basemodel.dart';
import 'package:new_ics/app/data/models/passport/base_country.dart';
import 'package:new_ics/app/modules/new_passport/controllers/new_passport_controller.dart';
import 'package:new_ics/app/theme/app_colors.dart';
import 'package:new_ics/app/theme/app_sizes.dart';
import 'package:new_ics/app/theme/app_text_styles.dart';
import 'package:new_ics/app/utils/validator_util.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

class Step3 extends StatefulWidget {
  final NewPassportController controller;

  const Step3({required this.controller});
  @override
  State<Step3> createState() => _Step4State();
}

class _Step4State extends State<Step3> {
  final NewPassportController controller = Get.find<NewPassportController>();

  // other properties go here
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80.w,
          child: Text(
            'Step 3'.tr,
            style: AppTextStyles.bodyLargeBold.copyWith(
              fontSize: AppSizes.font_14,
              color: AppColors.primary,
            ),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(height: 2.h),
        SizedBox(
          width: 80.w,
          child: Text(
            'Address And Contact Information'.tr,
            style: AppTextStyles.bodySmallRegular.copyWith(
              fontSize: AppSizes.font_12,
              color: AppColors.grayDark,
            ),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(height: 2.h),
        _buildPhoneInput(),
        buildEmailInput(),
        SizedBox(height: 2.h),
        _buildTextInput(controller.addressController, 'Address', true),
        SizedBox(height: 2.h),
        _buildCountryDropdown(
          'Select Current Country'.tr,
          controller.baseCountry,
          controller.currentcountryvalue.value,
          (value) async {
            controller.currentcountryvalue.value = value;
            // Reset all fields and variables here
          },
        ),
      ],
    );
  }

  Widget buildEmailInput() {
    return TextInputSignup(
      hint: 'Email'.tr,
      keyboardType: TextInputType.emailAddress,
      isPassword: false,
      onChanged: (value) {
        bool isValid = controller.validateEmail();
        controller.isEmailValid.value = isValid;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your email'.tr;
        }
        if (!controller.isEmailValid.value) {
          return 'Invalid email'.tr;
        }
        return null;
      },
      controller: controller.emailController,
      autofocus: false,
      focusNode: controller.emailFocusNode,
    );
  }

  Widget _buildCountryDropdown(
    String label,
    List<BaseCountry> countries,
    BaseCountry? currentValue,
    ValueChanged<BaseCountry?> onChanged,
  ) {
    if (countries.length > 10) {
      return CommonSearchDropDown(
        name: label.tr,
        options: countries,
        hint: label.tr,
        currentValue: currentValue,
        onChanged: onChanged,
        isEnabled: true,
        title: label.tr,
        validator: (BaseCountry? value) {
          if (value == null) {
            return 'Please select ${label}'.tr;
          }
          return null;
        },
      );
    } else {
      return FormBuilderDropdown<BaseCountry>(
        decoration: ReusableInputDecoration.getDecoration(
          label.tr,
          isMandatory: true,
        ),
        validator: (BaseCountry? value) {
          if (value == null) {
            return 'Please select ${label}'.tr;
          }
          return null;
        },
        items:
            countries.map((country) {
              return DropdownMenuItem<BaseCountry>(
                value: country,
                child: Text(
                  country.name,
                  style: AppTextStyles.captionBold.copyWith(
                    color: AppColors.grayDark,
                  ),
                ),
              );
            }).toList(),
        onChanged: onChanged,
        name: label.tr,
      );
    }
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
}
