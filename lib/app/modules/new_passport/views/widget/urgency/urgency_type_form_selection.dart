import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:new_ics/app/common/dropdown/common_search_drop_down.dart';
import 'package:new_ics/app/common/forms/phone_number_input.dart';
import 'package:new_ics/app/common/forms/reusableDropdown.dart';
import 'package:new_ics/app/common/forms/text_input_with_builder.dart';
import 'package:new_ics/app/common/model/basemodel.dart';
import 'package:new_ics/app/data/models/passport/base_country.dart';
import 'package:new_ics/app/data/models/passport/base_embassiy.dart';
import 'package:new_ics/app/data/models/passport/passport_urgency_type.dart';

import 'package:new_ics/app/modules/new_passport/controllers/new_passport_controller.dart';
import 'package:new_ics/app/theme/app_colors.dart';
import 'package:new_ics/app/theme/app_sizes.dart';
import 'package:new_ics/app/theme/app_text_styles.dart';
import 'package:new_ics/app/utils/validator_util.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UrgencyTypeSelection extends StatelessWidget {
  final NewPassportController controller;

  const UrgencyTypeSelection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ////////////////////////////////
        /// Collection Address
        _buildTitle(),
        SizedBox(height: 2.h),
        Obx(
          () => _buildCountryDropdown(
            'Collection country'.tr,
            controller.baseCountry,
            controller.collactioncountry.value,
            (value) async {
              controller.collactioncountry.value = value;
              // Reset all fields and variables here
              controller.isfechedEmbassies.value = false;
              controller.selectedUrgencyType.value = null;
              controller.baseEmbassies.clear();
              controller.filteredUrgencyTypes.clear();
              controller.embassiesvalue.value = null;
              await controller.getPassportUrgencyType();
              await controller.getEmbassies(
                controller.collactioncountry.value!.id,
              );
            },
          ),
        ),
        SizedBox(height: 2.h),
        Obx(
          () =>
              controller.isfechedEmbassies.value
                  ? _buildEmbassyDropdown(
                    controller.collactioncountry.value!.name == "Ethiopia"
                        ? "Branch"
                        : "Embassies",
                  )
                  : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Embassy or Branch  not Selected'.tr,
                        style: AppTextStyles.bodySmallBold.copyWith(
                          color: AppColors.danger,
                        ),
                      ),
                      Text(
                        'The Selected Collaction country do not have Embassy or Branch'
                            .tr,

                        style: AppTextStyles.menuBold.copyWith(
                          color: AppColors.dangerDark,
                        ),
                      ),
                    ],
                  ),
        ),
        ////////////////////////////////
        ///Select Urgency Level
        SizedBox(height: 2.h),
        _buildUrgencyTitle(),
        SizedBox(height: 2.h),

        Obx(
          () =>
              controller.collactioncountry.value != null
                  ? _buildUrgencyTypeDropdown()
                  : SizedBox(),
        ),
        // Obx(() {
        //   if (controller.selectedUrgencyType.value == null) return SizedBox();
        //   final selectedType = controller.selectedUrgencyType.value!.id;
        //   if (selectedType == null) return SizedBox();

        //   if (selectedType == 'ba490e60-0e37-4d23-9ba4-e4f1ab4da91d' ||
        //       selectedType == '0c0b9d23-1dcc-46f3-8600-fe329cbc6499' ||
        //       selectedType == 'd4877c04-1d53-4004-bb5a-35a51d7d3090') {
        //     return _buildUrgencyOptions();
        //   } else if (selectedType == '950bda37-10ed-4496-9979-b81a24ff8fd1') {
        //     return _buildSpecialUrgencyForm();
        //   } else {
        //     return _buildCollactionInformation();
        //   }
        // }),
      ],
    );
  }

  Widget _buildUrgencyTypeDropdown() {
    var urgencyTypess = controller.filteredUrgencyTypes;
    print("aefjbnj ${urgencyTypess.length}");
    return FormBuilderDropdown<BasePassportUrgencyType>(
      validator: (BasePassportUrgencyType? value) {
        if (value == null) {
          return 'Please Select Urgency Level'
              .tr; // Return an error message if no value is selected
        }
        return null; // Return null if the value is valid
      },
      decoration: ReusableInputDecoration.getDecoration(
        'Select Select Urgency Level',
        isMandatory: true,
      ),
      items:
          urgencyTypess.map((urgencyType) {
            return DropdownMenuItem<BasePassportUrgencyType>(
              value: urgencyType,
              child: Text(
                urgencyType.name ?? '',
                style: AppTextStyles.captionBold.copyWith(
                  color: AppColors.grayDark,
                ),
              ),
            );
          }).toList(),
      onChanged: (BasePassportUrgencyType? newValue) {
        if (newValue != null) {
          controller.setUrgencyType(newValue);
        }
      },
      name: 'Services',
      initialValue: controller.selectedUrgencyType.value,
    );
  }

  Widget _buildEmbassyDropdown(String label) {
    return Obx(() {
      return FormBuilderDropdown(
        decoration: ReusableInputDecoration.getDecoration(
          controller.collactioncountry.value!.name == "Ethiopia"
              ? "Branch".tr
              : "Embassies".tr,
          isMandatory: true,
        ),
        items:
            controller.baseEmbassies.map((BaseEmbassies value) {
              return DropdownMenuItem<BaseEmbassies>(
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
          controller.embassiesvalue.value = value;
          // controller.getBookedDates(value!.id!);
        },
        name:
            controller.collactioncountry.value!.name == "Ethiopia"
                ? "Branch".tr
                : 'Embassies'.tr,
        validator: FormBuilderValidators.required(),
      );
    });
  }

  Widget _buildTitle() {
    return Row(
      children: [
        Icon(Icons.location_city, color: AppColors.primary),
        SizedBox(width: 2.w),
        Text(
          'Collection address'.tr,
          style: AppTextStyles.bodySmallRegular.copyWith(
            color: AppColors.grayDark,
          ),
        ),
      ],
    );
  }

  Widget _buildUrgencyTitle() {
    return Row(
      children: [
        Icon(Icons.lock_clock, color: AppColors.primary),
        SizedBox(width: 2.w),
        Text(
          'Select Urgency Level'.tr,
          style: AppTextStyles.bodySmallRegular.copyWith(
            color: AppColors.grayDark,
          ),
        ),
      ],
    );
  }

  Widget _buildUrgencyOptions() {
    return FormBuilder(
      key: controller.urgencyFormKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        children: [
          _buildCollactionInformation(),
          controller.collactioncountry.value != null
              ? controller.collactioncountry.value!.name == "Ethiopia"
                  ? _buildDeliveryRadioGroup()
                  : SizedBox()
              : SizedBox(),
          SizedBox(height: 2.h),
          Obx(() {
            if (controller.isDeliveryRequired.value) {
              return _buildTextInput(
                controller.houseNumberforDeleivery,
                'House Number'.tr,
                true,
              );
            } else {
              return SizedBox();
            }
          }),
        ],
      ),
    );
  }

  Widget _buildDeliveryRadioGroup() {
    return Obx(() {
      return FormBuilderRadioGroup<bool>(
        name: 'delivery'.tr,
        activeColor: AppColors.primary,
        initialValue: controller.isDeliveryRequired.value,
        decoration: InputDecoration(
          labelText: 'Do you need delivery?'.tr,
          labelStyle: AppTextStyles.bodySmallRegular.copyWith(
            color: AppColors.grayDark,
          ),
        ),
        options: [
          FormBuilderFieldOption(value: true, child: Text('Yes'.tr)),
          FormBuilderFieldOption(value: false, child: Text('No'.tr)),
        ],
        onChanged: (bool? value) {
          controller.isDeliveryRequired.value = value ?? false;
        },
      );
    });
  }

  Widget _buildSpecialUrgencyForm() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(height: 2.h),
          Obx(
            () =>
                controller.isfechedregions.value
                    ? _buildRegsionDropdown('Region', controller.base_regions, (
                      value,
                    ) {
                      controller.regionsvalue.value = value!;
                      controller.baseCountry.clear();
                      controller.isfechedEmbassies.value = false;
                      controller.embassiesvalue.value =
                          null; // Clear the embassy value
                      controller.isfechedEmbassies.value = false;
                    })
                    : SizedBox(),
          ),
          SizedBox(height: 2.h),
          Obx(
            () =>
                controller.isfechedEmbassies.value
                    ? _buildEmbassyDropdownForSpecial(
                      controller.collactioncountry.value!.name == "Ethiopia"
                          ? "Branch"
                          : "Embassies",
                    )
                    : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Embassy not Selected'.tr,
                          style: AppTextStyles.bodySmallBold.copyWith(
                            color: AppColors.danger,
                          ),
                        ),
                        Text(
                          'The Selected Region do not have Embassy'.tr,
                          style: AppTextStyles.menuBold.copyWith(
                            color: AppColors.dangerDark,
                          ),
                        ),
                      ],
                    ),
          ),
          SizedBox(height: 2.h),
          _buildTextInput(
            controller.houseNumberforDeleivery,
            'House Number',
            true,
          ),
          SizedBox(height: 2.h),
          _buildTextInput(controller.deliveryAddress, 'Delivery Address', true),
          SizedBox(height: 2.h),
          _buildPhoneInput(),
        ],
      ),
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

  Widget _buildCollactionInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 2.h),
        _buildInfoHeader(
          'Address and collaction Information',
          AppSizes.font_12,
        ),
        SizedBox(height: 2.h),
        _buildCountryDropdown(
          'Select Collaction place',
          controller.baseCountry,
          controller.collactioncountry.value,
          (value) {
            controller.collactioncountry.value = value!;
            controller.base_regions.clear();
            controller.regionsvalue.value = null;
            controller.isfechedregions.value = false;
            //   controller.getRegion(controller.collactionPlace.value!.id!);
          },
        ),
        SizedBox(height: 2.h),
        Obx(
          () =>
              controller.isfechedregions.value
                  ? _buildRegsionDropdown('Region', controller.base_regions, (
                    value,
                  ) {
                    controller.regionsvalue.value = value!;
                    controller.baseEmbassies.clear();
                    controller.embassiesvalue.value =
                        null; // Clear the embassy value
                    controller.isfechedEmbassies.value = false;
                    // controller.getEmbassies(controller.regionsvalue.value!.id!);
                  })
                  : SizedBox(),
        ),
        SizedBox(height: 2.h),
        Obx(
          () =>
              controller.isfechedEmbassies.value
                  ? _buildEmbassyDropdown(
                    controller.collactioncountry.value!.name == "Ethiopia"
                        ? "Branch"
                        : "Embassies",
                  )
                  : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Embassy not Selected'.tr,
                        style: AppTextStyles.bodySmallBold.copyWith(
                          color: AppColors.danger,
                        ),
                      ),
                      Text(
                        'The Selected Collaction place do not have Embassy'.tr,
                        style: AppTextStyles.menuBold.copyWith(
                          color: AppColors.dangerDark,
                        ),
                      ),
                    ],
                  ),
        ),
        SizedBox(height: 2.h),
        _buildTextInput(
          controller.addressController,
          'Street details/Address line 1',
          true,
        ),
        SizedBox(height: 2.h),
        _buildPhoneInput(),
      ],
    );
  }

  Widget _buildInfoHeader(String title, double fontSize) {
    return SizedBox(
      width: 80.w,
      child: Text(
        title.tr,
        style: AppTextStyles.bodySmallRegular.copyWith(
          fontSize: fontSize,
          color: AppColors.grayDark,
        ),
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildRegsionDropdown(
    String label,
    List<CommonModel> regions,
    ValueChanged<CommonModel?> onChanged,
  ) {
    return FormBuilderDropdown(
      decoration: ReusableInputDecoration.getDecoration(
        label.tr,
        isMandatory: true,
      ),
      validator: (CommonModel? value) {
        if (value == null) {
          return 'Please select ${label}'.tr;
        }
        return null;
      },
      items:
          regions.map((regions) {
            return DropdownMenuItem<CommonModel>(
              value: regions,
              child: Text(
                regions.name,
                style: AppTextStyles.captionBold.copyWith(
                  color: AppColors.grayDark,
                ),
              ),
            );
          }).toList(),
      onChanged: (value) {
        onChanged(value);
        controller.embassiesvalue.value = null; // Clear the embassy value
        controller.baseEmbassies.clear(); // Clear the embassy list
      },
      name: label.tr,
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

  _buildEmbassyDropdownForSpecial(String s) {}

  // Widget _buildEmbassyDropdownForSpecial(String label) {
  //   return Obx(() {
  //     return FormBuilderDropdown(
  //       decoration: ReusableInputDecoration.getDecoration(
  //         controller.collactioncountry.value!.name == "Ethiopia"
  //             ? "Branch".tr
  //             : "Embassies".tr,
  //         isMandatory: true,
  //       ),
  //       items:
  //           controller.baseEmbassies.map((CommonModel value) {
  //             return DropdownMenuItem<CommonModel>(
  //               value: value,
  //               child: Text(
  //                 value.name,
  //                 style: AppTextStyles.captionBold.copyWith(
  //                   color: AppColors.grayDark,
  //                 ),
  //               ),
  //             );
  //           }).toList(),
  //       onChanged: (value) {
  //         controller.embassiesvalue.value = value;
  //       },
  //       name:
  //           controller.collactioncountry.value!.name == "Ethiopia"
  //               ? "Branch".tr
  //               : 'Embassies'.tr,
  //       validator: FormBuilderValidators.required(),
  //     );
  //   });
  // }
}
