import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_ics/app/common/app_toasts.dart';
import 'package:new_ics/app/common/appbar/customappbar.dart';
import 'package:new_ics/app/common/button/check_box.dart';
import 'package:new_ics/app/common/button/custom_normal_button.dart';
import 'package:new_ics/app/data/enums.dart';
import 'package:new_ics/app/modules/new_passport/views/widget/new_passport_urgency_type.dart';
import 'package:new_ics/app/routes/app_pages.dart';
import 'package:new_ics/app/theme/app_colors.dart';
import 'package:new_ics/app/theme/app_sizes.dart';
import 'package:new_ics/app/theme/app_text_styles.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

import '../../controllers/new_passport_controller.dart';

class InstructionCard extends StatelessWidget {
  final NewPassportController controller;

  const InstructionCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'New Passport'.tr,
        showLeading: true,
        title2: 'Instruction'.tr,
        showActions: true,
        actionIcon: Icon(Icons.close),
        routeName: () {
          Get.offAllNamed(Routes.MAIN_PAGE);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInstructionText(),
                SizedBox(height: 2.h),
                _buildConfirmationList(),
                SizedBox(height: 2.h),
                _buildInstructionText2(),
              ],
            ),
            ActionButtons(controller: controller),
          ],
        ),
      ),
    );
  }

  Widget _buildInstructionText() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        'Please ensure that you have the following documents before proceeding.'
            .tr,
        style: AppTextStyles.bodySmallRegular.copyWith(
          color: AppColors.grayDark,
        ),
      ),
    );
  }

  Widget _buildInstructionText2() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        'Users accept the responsibility for supplying, checking, and verifying the accuracy and correctness of the information they provide. Incorrect or inaccurate information may result in forfeiture of passport application. All fees are non-refundable. Fees shall be forfeited for applicants who fail to show up on their confirmed appointment, applicants who cancel their appointment, and applicants whose application was rejected due to incorrect information.'
            .tr,
        style: AppTextStyles.bodySmallRegular.copyWith(
          color: AppColors.black,
          fontSize: AppSizes.font_12,
        ),
      ),
    );
  }

  Widget _buildConfirmationList() {
    return Obx(() {
      if (controller.baseInstruction.isEmpty) {
        return Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        );
      } else {
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: controller.baseInstruction.length,
          itemBuilder: (context, index) {
            return _buildConfirmationItem(index);
          },
        );
      }
    });
  }

  Widget _buildConfirmationItem(int index) {
    BaseInstruction confirmation = controller.baseInstruction[index];

    return Obx(() {
      final isChecked = controller.isTermChecked(index);
      return GestureDetector(
        onTap: () => controller.toggleTerm(index),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: AppColors.grayLight.withOpacity(0.9),
              width: 1.0,
            ),
            color:
                isChecked
                    ? AppColors.primary.withOpacity(0.2)
                    : Colors.transparent,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildConfirmationDetails(confirmation, isChecked),
              _buildCheckBox(index, isChecked),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildConfirmationDetails(
    BaseInstruction confirmation,
    bool isChecked,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 3.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 50.w,
                child: Text(
                  confirmation.title.toString(),
                  style: AppTextStyles.bodySmallBold.copyWith(
                    fontSize: AppSizes.font_14,
                    color: AppColors.black,
                  ),
                ),
              ),
              SizedBox(
                width: 25.h,
                child: Text(
                  confirmation.description.toString(),
                  overflow: TextOverflow.fade,
                  maxLines: 6,
                  style: AppTextStyles.captionRegular.copyWith(
                    color: AppColors.black,
                    fontSize: AppSizes.font_10,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCheckBox(int index, bool isChecked) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: MyCheckBox(
        isInitSelected: isChecked,
        checkBoxSize: CheckBoxSize.MEDIUM,
        onChanged: (isChecked) => controller.toggleTerm(index),
        text: "",
      ),
    );
  }
}

class ActionButtons extends StatelessWidget {
  final NewPassportController controller;

  const ActionButtons({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.sp),
      child: Obx(() => _buildGetOnButton(context)),
    );
  }

  Widget _buildGetOnButton(BuildContext context) {
    return CustomNormalButton(
      text: 'Start individual Appointment'.tr,
      textStyle: AppTextStyles.bodyLargeBold.copyWith(
        color: AppColors.whiteOff,
        fontSize: AppSizes.font_12,
      ),
      textcolor: AppColors.whiteOff,
      buttoncolor:
          controller.areAllTermsSelected()
              ? AppColors.primary
              : AppColors.grayLight,
      borderRadius: AppSizes.radius_8,
      padding: EdgeInsets.symmetric(
        vertical: AppSizes.mp_v_2,
        horizontal: AppSizes.mp_w_6,
      ),
      onPressed: () {
        if (controller.areAllTermsSelected()) {
          _showSummeryDiloag(context);
        } else {
          AppToasts.showError("Error, Please select all terms".tr);
        }
      },
    );
  }

  _showSummeryDiloag(BuildContext context) {
    Get.to(() => NewPassportUrgencyType(controller: controller));
  }
}
