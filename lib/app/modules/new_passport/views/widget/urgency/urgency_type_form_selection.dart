import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:new_ics/app/common/dropdown/common_search_drop_down.dart';
import 'package:new_ics/app/common/forms/reusableDropdown.dart';
import 'package:new_ics/app/data/models/passport/base_country.dart';
import 'package:new_ics/app/data/models/passport/base_embassiy.dart';
import 'package:new_ics/app/data/models/passport/passport_page_size.dart';
import 'package:new_ics/app/data/models/passport/passport_urgency_type.dart';
import 'package:new_ics/app/modules/new_passport/controllers/new_passport_controller.dart';
import 'package:new_ics/app/theme/app_colors.dart';
import 'package:new_ics/app/theme/app_sizes.dart';
import 'package:new_ics/app/theme/app_text_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UrgencyTypeSelection extends StatelessWidget {
  final NewPassportController controller;

  const UrgencyTypeSelection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(),
        SizedBox(height: 2.h),
        _buildCountryDropdownSection(),
        SizedBox(height: 2.h),
        _buildEmbassyDropdownSection(),
        SizedBox(height: 2.h),
        _buildUrgencyLevelSection(),
        SizedBox(height: 2.h),
        _buildPageSizeSection(),
        SizedBox(height: 2.h),
        _buildPriceSummary(),
      ],
    );
  }

  Widget _buildCountryDropdownSection() {
    return Obx(
      () => _buildCountryDropdown(
        'Collection country'.tr,
        controller.baseCountry,
        controller.collactioncountry.value,
        (value) async {
          controller.collactioncountry.value = value;
          controller.isfechedEmbassies.value = false;
          controller.selectedUrgencyType.value = null;
          controller.baseEmbassies.clear();
          controller.filteredUrgencyTypes.clear();
          controller.embassiesvalue.value = null;
          await controller.getPassportUrgencyType();
          await controller.getEmbassies(controller.collactioncountry.value!.id);
        },
      ),
    );
  }

  Widget _buildEmbassyDropdownSection() {
    return Obx(
      () =>
          controller.isfechedEmbassies.value
              ? _buildEmbassyDropdown(
                controller.collactioncountry.value!.name == "Ethiopia"
                    ? "Branch"
                    : "Embassies",
              )
              : _buildEmbassyNotSelectedMessage(),
    );
  }

  Widget _buildEmbassyNotSelectedMessage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Embassy or Branch not Selected'.tr,
          style: AppTextStyles.bodySmallBold.copyWith(color: AppColors.danger),
        ),
        Text(
          'The Selected Collection country does not have an Embassy or Branch'
              .tr,
          style: AppTextStyles.menuBold.copyWith(color: AppColors.dangerDark),
        ),
      ],
    );
  }

  Widget _buildUrgencyLevelSection() {
    return Obx(
      () =>
          controller.collactioncountry.value != null
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildUrgencyTitle(),
                  SizedBox(height: 2.h),
                  _buildUrgencyTypeDropdown(),
                ],
              )
              : SizedBox(),
    );
  }

  Widget _buildPageSizeSection() {
    return Obx(
      () =>
          controller.collactioncountry.value != null
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPageSizeTitle(),
                  SizedBox(height: 2.h),
                  _buildPageSizeDropdown(),
                ],
              )
              : SizedBox(),
    );
  }

  Widget _buildPriceSummary() {
    return Obx(() {
      return controller.basePassportPrice.isNotEmpty
          ? Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.radius_8),
            ),
            color: AppColors.whiteOff,
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPriceSummaryHeader(),
                  SizedBox(height: 2.h),
                  _buildPriceRow(
                    'Currency:',
                    controller.collactioncountry.value!.name == "Ethiopia"
                        ? "ETB"
                        : "USD",
                  ),
                  SizedBox(height: 2.h),
                  _buildPriceRow(
                    'Service Price:',
                    controller.displayedPrice.value,
                  ),
                  SizedBox(height: 2.h),
                  _buildDeliveryPriceRow(),
                  SizedBox(height: 2.h),
                  _buildDeliveryCheckboxSection(),
                  _buildTotalPriceRow(
                    'Total Price:',
                    controller.isDeliveryRequired.value
                        ? (double.parse(controller.displayedPrice.value) +
                                double.parse(
                                  controller
                                          .embassiesvalue
                                          .value
                                          ?.delivery_price
                                          .toString() ??
                                      "0",
                                ))
                            .toStringAsFixed(2)
                        : controller.displayedPrice.value,
                  ),
                ],
              ),
            ),
          )
          : SizedBox();
    });
  }

  Widget _buildPriceSummaryHeader() {
    return Row(
      children: [
        Icon(Icons.money, color: AppColors.primary),
        SizedBox(width: 2.w),
        Text(
          'Payment Information',
          style: AppTextStyles.bodyLargeBold.copyWith(
            fontSize: AppSizes.font_18,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildDeliveryPriceRow() {
    return controller.isDeliveryRequired.value
        ? _buildPriceRow(
          'Delivery Price:',
          controller.embassiesvalue.value?.delivery_price.toString() ?? "0",
        )
        : SizedBox();
  }

  Widget _buildDeliveryCheckboxSection() {
    return Obx(() {
      return controller.collactioncountry.value != null &&
              controller.collactioncountry.value!.name == "Ethiopia" &&
              controller.embassiesvalue.value != null &&
              controller.embassiesvalue.value!.has_delivery
          ? _buildDeliveryCheckbox()
          : SizedBox();
    });
  }

  Widget _buildTotalPriceRow(String label, String value) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radius_4),
      ),
      color: Colors.green,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: AppTextStyles.bodyLargeBold.copyWith(
                fontSize: AppSizes.font_16,
                color: AppColors.whiteOff,
              ),
            ),
            Text(
              value,
              style: AppTextStyles.bodyLargeBold.copyWith(
                fontSize: AppSizes.font_16,
                color: AppColors.whiteOff,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyLargeBold.copyWith(
            fontSize: AppSizes.font_14,
            color: AppColors.primary,
          ),
        ),
        Text(
          value,
          style: AppTextStyles.bodyLargeBold.copyWith(
            fontSize: AppSizes.font_14,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildPageSizeDropdown() {
    return FormBuilderDropdown<BasePassportPageSize>(
      decoration: ReusableInputDecoration.getDecoration(
        'Passport Page Size'.tr,
        isMandatory: true,
      ),
      validator: (BasePassportPageSize? value) {
        if (value == null) {
          return 'Please select Passport Page Size'.tr;
        }
        return null;
      },
      initialValue: controller.pagesizeValuevalue.value,
      items:
          controller.basePassportPageSize.map((value) {
            return DropdownMenuItem<BasePassportPageSize>(
              value: value,
              child: Text(
                value.name!,
                style: AppTextStyles.captionBold.copyWith(
                  color: AppColors.grayDark,
                ),
              ),
            );
          }).toList(),
      onChanged: (value) {
        controller.pagesizeValuevalue.value = value!;
        controller.getPassportPrice();
      },
      name: 'Passport Page Size'.tr,
    );
  }

  Widget _buildUrgencyTypeDropdown() {
    var urgencyTypes = controller.filteredUrgencyTypes;

    return FormBuilderDropdown<BasePassportUrgencyType>(
      validator: (BasePassportUrgencyType? value) {
        if (value == null) {
          return 'Please Select Urgency Level'.tr;
        }
        return null;
      },
      decoration: ReusableInputDecoration.getDecoration(
        'Select Urgency Level',
        isMandatory: true,
      ),
      items:
          urgencyTypes.map((urgencyType) {
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

  Widget _buildPageSizeTitle() {
    return Row(
      children: [
        Icon(Icons.note, color: AppColors.primary),
        SizedBox(width: 2.w),
        Text(
          'Select Passport Page Size'.tr,
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

  Widget _buildDeliveryCheckbox() {
    return Obx(() {
      return FormBuilderCheckbox(
        name: 'delivery'.tr,
        initialValue: controller.isDeliveryRequired.value,
        title: Text(
          'I want delivery service'.tr,
          style: AppTextStyles.bodySmallRegular.copyWith(
            color: AppColors.grayDark,
          ),
        ),
        onChanged: (bool? value) {
          controller.isDeliveryRequired.value = value ?? false;
        },
        activeColor: AppColors.primary,
      );
    });
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
}
