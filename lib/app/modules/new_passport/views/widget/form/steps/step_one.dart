// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:new_ics/app/common/datepicker/date_text_picker_input.dart';
import 'package:new_ics/app/common/dropdown/common_search_drop_down.dart';
import 'package:new_ics/app/common/forms/form_lable.dart';
import 'package:new_ics/app/common/forms/reusableDropdown.dart';
import 'package:new_ics/app/common/forms/text_input_with_builder.dart';
import 'package:new_ics/app/common/model/basemodel.dart';
import 'package:new_ics/app/data/models/passport/base_country.dart';
import 'package:new_ics/app/modules/new_passport/controllers/new_passport_controller.dart';
import 'package:new_ics/app/theme/app_colors.dart';
import 'package:new_ics/app/theme/app_sizes.dart';
import 'package:new_ics/app/theme/app_text_styles.dart';
import 'package:new_ics/app/utils/validator_util.dart';

import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/services.dart';

class Step1 extends StatelessWidget {
  final NewPassportController controller;

  Step1({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStepTitle('Step 1', AppColors.primary),
        _buildSubtitle('Personal profile'.tr, AppColors.grayDark),
        _buildInputField(
          label: 'First name'.tr,
          controller: controller.firstNameController,
          isMandatory: true,
          hint: 'First name'.tr,
          inputFormatters: [NoNumberInputFormatter()],
        ),
        _buildInputField(
          label: 'Father Name'.tr,
          controller: controller.fatherNameController,
          isMandatory: true,
          hint: 'Father Name'.tr,
          inputFormatters: [NoNumberInputFormatter()],
        ),
        _buildInputField(
          label: 'Grand Father Name'.tr,
          controller: controller.grandFatherNameController,
          isMandatory: true,
          hint: 'Grand Father Name'.tr,
          inputFormatters: [NoNumberInputFormatter()],
        ),
        _buildAmharicKeyboardPrompt(),
        _buildInputField(
          label: "የመጀመሪያ ስም",
          controller: controller.AmfirstNameController,
          isMandatory: true,
          hint: 'የመጀመሪያ ስም',
          inputFormatters: [AmharicInputFormatter()],
        ),
        _buildInputField(
          label: 'የአባት ስም',
          controller: controller.AmfatherNameController,
          isMandatory: true,
          hint: 'የአባት ስም',
          inputFormatters: [AmharicInputFormatter()],
        ),
        _buildInputField(
          label: 'የአያት ስም',
          controller: controller.AmgrandFatherNameController,
          isMandatory: true,
          hint: 'የአያት ስም',
          inputFormatters: [AmharicInputFormatter()],
        ),
        _buildDatePicker(),

        SizedBox(height: 2.h),
        _buildBirthCountryDropdown(),
        _buildInputField(
          label: 'Birth place'.tr,
          controller: controller.birthplace,
          isMandatory: true,
          hint: 'Birth place'.tr,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z0-9\s]")),
          ],
        ),
        _buildGenderDropdown(),
        _buildAdoptionCheckbox(),
      ],
    );
  }

  Widget _buildStepTitle(String title, Color color) {
    return SizedBox(
      width: 80.w,
      child: Text(
        title.tr,
        style: AppTextStyles.bodyLargeBold.copyWith(
          fontSize: AppSizes.font_14,
          color: color,
        ),
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildSubtitle(String subtitle, Color color) {
    return SizedBox(
      height: 3.h,
      child: SizedBox(
        width: 80.w,
        child: Text(
          subtitle.tr,
          style: AppTextStyles.bodySmallRegular.copyWith(
            fontSize: AppSizes.font_12,
            color: color,
          ),
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    bool isMandatory = false,
    required String hint,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Column(
      children: [
        TextFormBuilder(
          isMandatory: isMandatory,
          controller: controller,
          validator:
              ValidationBuilder().required('$label is required'.tr).build(),
          hint: hint.tr,
          labelText: label.tr,
          inputFormatters: inputFormatters,
          showClearButton: false,
          autoFocus: false,
          onChanged: (value) {},
        ),
        SizedBox(height: 2.h),
      ],
    );
  }

  Widget _buildAmharicKeyboardPrompt() {
    return Column(
      children: [
        FormLabelWidget(
          title: 'Please use Amharic keyboard'.tr,
          isRequired: false,
          color: AppColors.primary,
          leftIcon: Icon(
            Icons.keyboard,
            color: AppColors.secondary,
            size: AppSizes.icon_size_6,
          ),
        ),
        SizedBox(height: 3.h),
      ],
    );
  }

  Widget _buildDatePicker() {
    return Column(
      children: [
        Text(
          'Birth date'.tr,
          style: AppTextStyles.captionBold.copyWith(
            color: AppColors.grayLight,
            fontSize: AppSizes.font_12,
          ),
        ),
        DateTextPickerInputReNewPassport(
          yearValidator:
              ValidationBuilder().required('year is required'.tr).build(),
          monthValidator:
              ValidationBuilder().required('month is required'.tr).build(),
          dateValidator:
              ValidationBuilder().required('date is required'.tr).build(),
          controller: controller,
        ),
        SizedBox(height: 2.h),
      ],
    );
  }

  Widget _buildBirthCountryDropdown() {
    return _buildCountryDropdown(
      'Birth Country'.tr,
      controller.bcountries,
      controller.birthCountryvalue.value,
      (value) {
        controller.birthCountryvalue.value = value;
      },
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

  Widget _buildDropdown({
    required String label,
    required List<CommonModel> items,
    required Function(CommonModel?) onChanged,
    CommonModel? initialValue,
  }) {
    return Column(
      children: [
        FormBuilderDropdown(
          decoration: ReusableInputDecoration.getDecoration(label.tr),
          items:
              items.map((CommonModel value) {
                return DropdownMenuItem<CommonModel>(
                  value: value,
                  child: Text(
                    value.name,
                    style: AppTextStyles.captionBold.copyWith(
                      color: AppColors.grayDark,
                    ),
                  ),
                );
              }).toList(),
          onChanged: onChanged,
          name: label.tr,
          initialValue: initialValue,
        ),
        SizedBox(height: 2.h),
      ],
    );
  }

  Widget _buildGenderDropdown() {
    return _buildDropdown(
      label: 'Gender'.tr,
      items: controller.gender,
      onChanged: (value) {
        controller.gendervalue.value = value!;
      },
      initialValue: null,
    );
  }

  Widget _buildAdoptionCheckbox() {
    return Obx(() {
      if (controller.showAdoption.value) {
        return Column(
          children: [
            Text(
              'Is Adoption ?'.tr,
              style: AppTextStyles.captionBold.copyWith(
                color: AppColors.grayLight,
                fontSize: AppSizes.font_12,
              ),
            ),
            FormBuilderCheckbox(
              initialValue: null,
              decoration: InputDecoration(border: InputBorder.none),
              name: 'Is Adoption'.tr,
              title: Text(
                'Is Adoption'.tr,
                style: AppTextStyles.captionBold.copyWith(
                  color: AppColors.black,
                  fontSize: AppSizes.font_12,
                ),
              ),
              activeColor: AppColors.primary,
              onChanged: (value) {
                controller.isAdoption.value = value!;
                if (controller.isAdoption.value) {
                  controller.addtoDocumants(CommonModel(name: "Ado", id: ""));
                } else {
                  controller.removeFromDocumants(
                    CommonModel(name: "Ado", id: ""),
                  );
                }
             //   controller.mapBaseDataToLists();
              },
            ),
            SizedBox(height: 2.h),
          ],
        );
      } else {
        return SizedBox();
      }
    });
  }
}
