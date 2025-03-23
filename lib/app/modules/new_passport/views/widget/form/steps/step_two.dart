import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:new_ics/app/common/forms/reusableDropdown.dart';
import 'package:new_ics/app/common/forms/text_input_with_builder.dart';
import 'package:new_ics/app/common/model/basemodel.dart';
import 'package:new_ics/app/common/photo_upload/photo_upload.dart';
import 'package:new_ics/app/modules/new_passport/controllers/new_passport_controller.dart';
import 'package:new_ics/app/theme/app_colors.dart';
import 'package:new_ics/app/theme/app_sizes.dart';
import 'package:new_ics/app/theme/app_text_styles.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:flutter/services.dart';

class Step2 extends StatelessWidget {
  final NewPassportController controller;

  const Step2({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader('Step 2'.tr, AppColors.primary),
        _buildHeader(
          'Personal profile'.tr,
          AppColors.grayDark,
          fontSize: AppSizes.font_12,
        ),
        SizedBox(height: 2.h),
        _buildDropdownField(
          title: 'Occupation'.tr,
          items: controller.occupations,
          onChanged: (value) => controller.occupationvalue.value = value,
          initialValue: null,
        ),
        SizedBox(height: 2.h),
        _buildDropdownField(
          title: 'Hair Color'.tr,
          items: controller.haircolor,
          onChanged: (value) => controller.haircolorvalue.value = value!,
          initialValue: null,
        ),
        SizedBox(height: 2.h),
        _buildDropdownField(
          title: 'Eye Color'.tr,
          items: controller.eyecolor,
          onChanged: (value) => controller.eyecolorvalue.value = value!,
          initialValue: null,
        ),
        SizedBox(height: 2.h),
        FormBuilderDropdown(
          decoration: ReusableInputDecoration.getDecoration(
            'Skin Color'.tr,
            isMandatory: false,
          ),
          items:
              controller.SkinColor.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: AppTextStyles.captionBold.copyWith(
                      color: AppColors.grayDark,
                    ),
                  ),
                );
              }).toList(),
          onChanged: (value) {
            controller.skincolorvalue.value = value!;
          },
          name: 'Skin'.tr,
          initialValue: null,
        ),
        SizedBox(height: 2.h),
        _buildMaritalStatusDropdown(),
        SizedBox(height: 2.h),
        _buildHeightInputField(),
        SizedBox(height: 2.h),
        PhotoUpload(
          selectedImages: controller.selectedImages,
          photoPath: controller.photoPath,
        ),
      ],
    );
  }

  _buildHeader(String title, Color color, {double fontSize = 14}) {
    return SizedBox(
      width: 80.w,
      child: Text(
        title.tr,
        style: AppTextStyles.bodyLargeBold.copyWith(
          fontSize: fontSize,
          color: color,
        ),
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildDropdownField({
    required String title,
    required List<CommonModel> items,
    required Function(CommonModel?) onChanged,
    CommonModel? initialValue,
  }) {
    return Column(
      children: [
        SizedBox(height: 2.h),
        FormBuilderDropdown<CommonModel>(
          decoration: ReusableInputDecoration.getDecoration(
            title,
            isMandatory: false,
          ),
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
          name: title,
          initialValue: initialValue,
        ),
      ],
    );
  }

  Widget _buildMaritalStatusDropdown() {
    return _buildDropdownField(
      title: 'Marital Status'.tr,
      items: controller.martial,
      onChanged: (value) => controller.maritalstatusvalue.value = value!,
      initialValue: null,
    );
  }

  Widget _buildHeightInputField() {
    return TextFormBuilder(
      isMandatory: false,
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          RegExp(r'^\d{0,3}(\.\d{0,2})?$'),
        ), // Allow only positive numbers with up to 2 decimal places.
      ],
      controller: controller.height,
      hint: '(e.g., "1.70 meters")'.tr,
      keyboardType: TextInputType.number,
      labelText: 'Height(cm)'.tr,
      showClearButton: false,
      autoFocus: false,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a height'.tr;
        }
        final height = double.tryParse(value);
        if (height == null || height <= 0 || height > 300) {
          return 'Please enter a valid height between 1 and 300 cm'.tr;
        }
        return null;
      },
      onChanged: (value) {},
    );
  }
}
