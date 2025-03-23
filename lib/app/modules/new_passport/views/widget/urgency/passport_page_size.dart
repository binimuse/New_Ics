import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:new_ics/app/common/appbar/customappbar.dart';
import 'package:new_ics/app/common/button/custom_normal_button.dart';
import 'package:new_ics/app/common/forms/reusableDropdown.dart';
import 'package:new_ics/app/common/loading/custom_loading_widget.dart';
import 'package:new_ics/app/data/enums.dart';
import 'package:new_ics/app/data/models/passport/passport_page_size.dart';
import 'package:new_ics/app/modules/new_passport/controllers/new_passport_controller.dart';
import 'package:new_ics/app/routes/app_pages.dart';
import 'package:new_ics/app/theme/app_colors.dart';
import 'package:new_ics/app/theme/app_sizes.dart';
import 'package:new_ics/app/theme/app_text_styles.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

class PassportPageSize extends StatelessWidget {
  final NewPassportController controller;

  const PassportPageSize({required this.controller, Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Select Passport'.tr,
        title2: "Page Size".tr,
        showLeading: true,
        showActions: true,
        actionIcon: Icon(Icons.close),
        routeName: () {
          Get.offAllNamed(Routes.MAIN_PAGE);
        },
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2.h),
                Text(
                  'Choose Your Passport Page Size'.tr,
                  style: AppTextStyles.menuBold.copyWith(
                    fontSize: AppSizes.font_14,
                    color: AppColors.grayDark,
                  ),
                  maxLines: 2,
                ),
                SizedBox(height: 2.h),
                _buildPageSizeDropdown(),
                SizedBox(height: 2.h),
                Text(
                  'Passport Price'.tr,
                  style: AppTextStyles.bodySmallRegular.copyWith(
                    fontSize: AppSizes.font_12,
                    color: AppColors.grayDark,
                  ),
                ),
                SizedBox(height: 1.h),
                _buildPriceSummary(),
                Spacer(),
              ],
            ),
          ),
          _buildNextButton(),
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

  Widget _buildPageSizeDropdown() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radius_8),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
        child: FormBuilderDropdown<BasePassportPageSize>(
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
                    style: AppTextStyles.menuRegular.copyWith(
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
        ),
      ),
    );
  }

  Widget _buildPriceSummary() {
    return Obx(() {
      return controller.basePassportPrice.isNotEmpty
          ? Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.radius_8),
            ),
            color: AppColors.primary.withOpacity(0.2),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Price Summary',
                    style: AppTextStyles.bodyLargeBold.copyWith(
                      fontSize: AppSizes.font_18,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 8),
                  _buildPriceRow(
                    'Currency:',
                    controller.collactioncountry.value!.name == "Ethiopia"
                        ? "ETB"
                        : "USD",
                  ),
                  SizedBox(height: 8),
                  _buildPriceRow(
                    'Service Price:',
                    controller.displayedPrice.value,
                  ),
                  SizedBox(height: 8),
                  controller.isDeliveryRequired.value
                      ? _buildPriceRow('Delivery Price:', "1000")
                      : SizedBox(),
                  SizedBox(height: 8),
                  _buildPriceRow(
                    'Total Price:',
                    controller.isDeliveryRequired.value
                        ? (double.parse(controller.displayedPrice.value) +
                                double.parse("1000"))
                            .toStringAsFixed(2)
                        : controller.displayedPrice.value,
                  ),
                ],
              ),
            ),
          )
          : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Passport Price Not Found'.tr,
                style: AppTextStyles.bodySmallBold.copyWith(
                  color: AppColors.danger,
                ),
              ),
            ],
          );
    });
  }

  Widget _buildPriceRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyLargeBold.copyWith(
            fontSize: AppSizes.font_16,
            color: AppColors.primary,
          ),
        ),
        Text(
          value,
          style: AppTextStyles.bodyLargeBold.copyWith(
            fontSize: AppSizes.font_16,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildNextButton() {
    return Positioned(
      bottom: 16.0,
      left: 16.0,
      right: 16.0,
      child: Obx(() {
        final isPageSizeSelected = controller.pagesizeValuevalue.value != null;
        final isPriceAvailable = controller.basePassportPrice.isNotEmpty;
        final isButtonEnabled = isPageSizeSelected && isPriceAvailable;

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
