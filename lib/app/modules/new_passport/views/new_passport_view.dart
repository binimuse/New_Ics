import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:new_ics/app/common/appbar/customappbar.dart';
import 'package:new_ics/app/common/loading/custom_loading_widget.dart';
import 'package:new_ics/app/data/enums.dart';
import 'package:new_ics/app/data/models/passport/passport_type.dart';
import 'package:new_ics/app/modules/new_passport/views/widget/instaraction_card.dart';
import 'package:new_ics/app/theme/app_colors.dart';
import 'package:new_ics/app/theme/app_sizes.dart';
import 'package:new_ics/app/theme/app_text_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controllers/new_passport_controller.dart';

class NewPassportView extends GetView<NewPassportController> {
  const NewPassportView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'New'.tr,
        title2: "Passport type".tr,
        showLeading: true,
      ),
      backgroundColor: AppColors.whiteOff,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: 2.h),
                Expanded(
                  child: _PassportTypeList(controller: controller),
                ), // Make list scrollable
              ],
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

class _PassportTypeList extends StatelessWidget {
  final NewPassportController controller;
  const _PassportTypeList({required this.controller, Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final passportTypes = controller.passportTypeResponse;
      return ListView.builder(
        itemCount: passportTypes.length,
        itemBuilder: (context, index) {
          final passportType = passportTypes[index];
          return _PassportTypeItem(
            passportType: passportType,
            isSelected: controller.selectedPassportType.value == passportType,
            onTap: () {
              controller.setPassportType(passportType);
              Get.to(() => InstructionCard(controller: controller));
            },
          );
        },
      );
    });
  }
}

class _PassportTypeItem extends StatelessWidget {
  final PassportTypeResponse passportType;
  final bool isSelected;
  final VoidCallback onTap;

  const _PassportTypeItem({
    required this.passportType,
    required this.isSelected,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: AppColors.grayLight.withOpacity(0.9),
            width: 1.0,
          ),
          color:
              isSelected
                  ? AppColors.primary.withOpacity(0.2)
                  : Colors.transparent,
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'assets/icons/paper.svg',
                    color: AppColors.primary,
                  ),
                  SizedBox(width: 3.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        passportType.name ?? '',
                        style: AppTextStyles.bodySmallBold.copyWith(
                          fontSize: AppSizes.font_14,
                          color: AppColors.black,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      SizedBox(
                        width: 63.w,
                        child: Text(
                          passportType.description ?? '',
                          style: AppTextStyles.bodySmallBold.copyWith(
                            fontSize: AppSizes.font_10 * 1.2,
                            color: AppColors.grayLight,
                          ),
                          maxLines: 9,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary.withOpacity(
                      0.2,
                    ), // Blue color for the circle
                  ),
                  child: Icon(
                    Icons.arrow_forward_outlined,
                    color: AppColors.primary,
                    size: 12,
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  "View Details".tr,
                  style: AppTextStyles.bodyLargeRegular.copyWith(
                    fontSize: AppSizes.font_12,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
