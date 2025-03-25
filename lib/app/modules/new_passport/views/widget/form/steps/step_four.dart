// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:new_ics/app/common/forms/reusableDropdown.dart';
import 'package:new_ics/app/common/forms/text_input_with_builder.dart';
import 'package:new_ics/app/common/model/basemodel.dart';
import 'package:new_ics/app/data/models/passport/base_country.dart';
import 'package:new_ics/app/data/models/passport/base_occupation.dart';
import 'package:new_ics/app/modules/new_passport/controllers/new_passport_controller.dart';
import 'package:new_ics/app/theme/app_colors.dart';
import 'package:new_ics/app/theme/app_sizes.dart';
import 'package:new_ics/app/theme/app_text_styles.dart';
import 'package:new_ics/app/utils/validator_util.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

class Step4 extends StatefulWidget {
  final NewPassportController controller;

  const Step4({required this.controller});
  @override
  State<Step4> createState() => _Step4State();
}

class _Step4State extends State<Step4> {
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
            'Step 4'.tr,
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
            'Family Details.'.tr,
            style: AppTextStyles.bodySmallRegular.copyWith(
              fontSize: AppSizes.font_12,
              color: AppColors.grayDark,
            ),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(height: 4.h),
        Obx(
          () =>
              controller.familyModelvalue.isEmpty ? buildEmpty() : buildCard(),
        ),
        SizedBox(height: 4.h),
        buildaddButton(context),
        SizedBox(height: 2.h),
      ],
    );
  }

  buildCard() {
    return Container(
      height: 35.h,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Obx(
              () =>
                  controller.familyModelvalue.isNotEmpty
                      ? Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSizes.mp_w_6,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: AppSizes.mp_v_2 * 1.5),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: controller.familyModelvalue.length,
                              separatorBuilder:
                                  (context, index) =>
                                      SizedBox(height: AppSizes.mp_v_2 * 1.5),
                              itemBuilder: (context, index) {
                                var citizen =
                                    controller.familyModelvalue[index];
                                return buildInfoItem(citizen, index);
                              },
                            ),
                          ],
                        ),
                      )
                      : Center(child: SizedBox()),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEmpty() {
    return Center(
      child: Container(
        color: AppColors.backgroundLight,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "No family added yet.".tr,
              style: AppTextStyles.titleBold.copyWith(
                color: AppColors.grayDark,
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildaddButton(BuildContext context) {
    return InkWell(
      onTap: () {
        _showAddFamilyDialog(context);
      },
      child: Container(
        width: 100.w,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primaryLighter.withOpacity(0.3),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.add_box_outlined, color: AppColors.primary),
              const SizedBox(width: 4),
              Text(
                'Add Family'.tr,
                style: AppTextStyles.bodySmallBold.copyWith(
                  color: AppColors.primary,
                ),
              ),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddFamilyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Column(
              children: [
                Text("Family Details".tr, style: AppTextStyles.bodyLargeBold),
              ],
            ),
          ),
          content: Container(
            height: 40.h,
            child: Column(
              children: [
                buildFamilyType(),
                SizedBox(height: 2.h),
                buildFirstName(),
                SizedBox(height: 2.h),
                buildFatherName(),
                SizedBox(height: 2.h),
                buildNationality(),
                SizedBox(height: 2.h),
              ],
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.of(
                  context,
                ).pop(false); // Return false if cancel is pressed
              },
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(vertical: 5),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 4.h,
                width: 25.w,
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
                    "Cancel".tr,
                    style: AppTextStyles.bodyLargeBold.copyWith(
                      color: AppColors.whiteOff,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (controller.familyModelvalue.length < 10 &&
                    controller.newPassportformKey.currentState!.validate()) {
                  // Check if the list length is less than 10
                  Navigator.of(
                    context,
                  ).pop(true); // Return false if cancel is pressed
                  // Add the new item to the list
                  controller.familyModelvalue.add(
                    FamilyModel(
                      first_name: controller.familyfirstNameController.text,
                      father_name: controller.familyFatherNameController.text,
                      nationality_id:
                          controller.familynatinalityvalue.value!.id,
                      family_type: controller.familytypevalue.value!,
                    ),
                  );
                  clearField();
                } else {
                  clearField();
                  // Show an error message or display a toast indicating that the limit has been reached
                  // ...
                }
              },
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(vertical: 5),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 4.h,
                width: 25.w,
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
                    "Add".tr,
                    style: AppTextStyles.bodyLargeBold.copyWith(
                      color: AppColors.whiteOff,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  buildFamilyType() {
    return FormBuilderDropdown(
      decoration: ReusableInputDecoration.getDecoration('Family type'.tr),
      items:
          controller.baseOccupation.map((BaseOccupation value) {
            return DropdownMenuItem<BaseOccupation>(
              value: value,
              child: Text(
                value.name,
                style: AppTextStyles.captionBold.copyWith(
                  color: AppColors.grayDark,
                ),
              ),
            );
          }).toList(),
      onChanged: (value) {
        controller.familytypevalue.value = value;
      },
      name: 'Family type'.tr,
    );
  }

  buildFirstName() {
    return TextFormBuilder(
      isMandatory: true,
      validator:
          ValidationBuilder()
              .required('family First Name is required'.tr)
              .build(),
      labelText: "First name".tr,
      controller: controller.familyfirstNameController,
      inputFormatters: [NoNumberInputFormatter()],
      hint: 'First name'.tr,
      showClearButton: false,
      autoFocus: false,
      onChanged: (value) {},
    );
  }

  buildFatherName() {
    return TextFormBuilder(
      isMandatory: true,
      controller: controller.familyFatherNameController,
      validator:
          ValidationBuilder()
              .required('Family Father Name is required'.tr)
              .build(),
      hint: 'Father Name'.tr,
      labelText: 'Father Name'.tr,
      inputFormatters: [NoNumberInputFormatter()],
      showClearButton: false,
      autoFocus: false,
      onChanged: (value) {},
    );
  }

  buildNationality() {
    return FormBuilderDropdown(
      decoration: ReusableInputDecoration.getDecoration('Nationality'.tr),
      items:
          controller.baseCountry.map((BaseCountry value) {
            return DropdownMenuItem<BaseCountry>(
              value: value,
              child: Text(
                value.name,
                style: AppTextStyles.captionBold.copyWith(
                  color: AppColors.grayDark,
                ),
              ),
            );
          }).toList(),
      onChanged: (value) {
        controller.familynatinalityvalue.value = value;
      },
      name: 'Nationality'.tr,
    );
  }

  buildInfoItem(FamilyModel familyModel, int index) {
    return Container(
      height: 14.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: AppColors.grayLight, width: 1.0),
        color: AppColors.whiteOff,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              color: AppColors.grayLighter,
            ),
            height: 5.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 3.w),
                SizedBox(width: AppSizes.mp_v_1),
                Text(
                  familyModel.father_name.toString() +
                      " " +
                      familyModel.father_name.toString(),
                  style: AppTextStyles.bodySmallBold.copyWith(
                    color: AppColors.grayDark,
                    fontSize: AppSizes.font_12 * 1.0,
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.delete, color: AppColors.danger),
                  onPressed: () {
                    controller.familyModelvalue.removeAt(index);
                  },
                ),
              ],
            ),
          ),
          SizedBox(width: AppSizes.mp_v_4),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 9.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  familyModel.family_type!.name.toString(),
                  style: AppTextStyles.bodySmallRegular.copyWith(
                    color: AppColors.grayDark,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void clearField() {
    controller.familyfirstNameController.clear();
    controller.familyFatherNameController.clear();
    controller.familytypevalue.value = null;
    controller.familynatinalityvalue.value = null;
  }
}
