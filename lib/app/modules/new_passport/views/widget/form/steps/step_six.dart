// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:new_ics/app/common/custom_callender.dart';
import 'package:new_ics/app/modules/new_passport/controllers/new_passport_controller.dart';
import 'package:new_ics/app/theme/app_colors.dart';
import 'package:new_ics/app/theme/app_sizes.dart';
import 'package:new_ics/app/theme/app_text_styles.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:interval_time_picker/interval_time_picker.dart';

class Step6 extends StatelessWidget {
  final NewPassportController controller = Get.find<NewPassportController>();
  // other properties go here
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 20.w,
          child: Text(
            'Step 6'.tr,
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
          child: Text(
            'Payment'.tr,
            style: AppTextStyles.bodySmallRegular.copyWith(
              fontSize: AppSizes.font_12,
              color: AppColors.grayDark,
            ),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(height: 2.h),
        buildPriceSection(),
        SizedBox(height: 1.h),
        Divider(
          color: AppColors.backgroundDark,
          thickness: AppSizes.mp_v_2 * 0.7,
        ),
        SizedBox(height: 1.h),
        buildLocalPaymentMethod(),
        SizedBox(height: AppSizes.mp_v_4),
        SizedBox(height: 1.h),
        buildPaymentMethod(),
        SizedBox(height: AppSizes.mp_v_4),
      ],
    );
  }

  buildLocalPaymentMethod() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Local Payment Method".tr, style: AppTextStyles.titleBold),
        SizedBox(height: AppSizes.mp_v_2),
        creditCard(
          "TeleBirr",
          "https://raw.githubusercontent.com/Chapa-Et/ethiopianlogos/main/logos/tele_birr/tele_birr.svg",
        ),
        SizedBox(height: AppSizes.mp_v_2),
        creditCard(
          "CBE",
          "https://raw.githubusercontent.com/Chapa-Et/ethiopianlogos/main/logos/commercial_bank_of_ethiopia/commercial_bank_of_ethiopia.svg",
        ),
      ],
    );
  }

  buildPaymentMethod() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("International Payment Method".tr, style: AppTextStyles.titleBold),
        SizedBox(height: AppSizes.mp_v_2),
        creditCard(
          "Visa Card".tr,
          "https://raw.githubusercontent.com/aaronfagan/svg-credit-card-payment-icons/main/flat/visa.svg",
        ),
        SizedBox(height: AppSizes.mp_v_2),
        creditCard(
          "Master Card",
          "https://raw.githubusercontent.com/aaronfagan/svg-credit-card-payment-icons/main/flat/mastercard.svg",
        ),
        SizedBox(height: AppSizes.mp_v_2),
        creditCard(
          "American Express",
          "https://raw.githubusercontent.com/aaronfagan/svg-credit-card-payment-icons/main/flat/amex.svg",
        ),
      ],
    );
  }

  buildPriceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Price".tr, style: AppTextStyles.titleBold),
        SizedBox(height: AppSizes.mp_v_2),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "Service fee".tr,
              style: AppTextStyles.bodySmallRegular.copyWith(
                color: AppColors.grayDefault,
              ),
            ),
            const Expanded(child: SizedBox()),
            Text("\$5.75", style: AppTextStyles.bodyLargeBold),
          ],
        ),
        SizedBox(height: AppSizes.mp_v_2),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "Card Fee".tr,
              style: AppTextStyles.bodySmallRegular.copyWith(
                color: AppColors.grayDefault,
              ),
            ),
            const Expanded(child: SizedBox()),
            Text("\$5.75", style: AppTextStyles.bodyLargeBold),
          ],
        ),
        SizedBox(height: AppSizes.mp_v_1),
        Divider(color: AppColors.grayLighter),
        SizedBox(height: AppSizes.mp_v_1),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "Total".tr,
              style: AppTextStyles.titleBold.copyWith(
                color: AppColors.grayDefault,
              ),
            ),
            const Expanded(child: SizedBox()),
            Text(
              "100 \$",
              style: AppTextStyles.titleBold.copyWith(color: AppColors.primary),
            ),
          ],
        ),
      ],
    );
  }

  creditCard(String title, String link) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SvgPicture.network(
          link,
          fit: BoxFit.cover,
          height: AppSizes.icon_size_8,
          width: AppSizes.icon_size_8,
        ),
        SizedBox(width: AppSizes.mp_w_8),
        Text(
          title,
          style: AppTextStyles.bodyLargeBold.copyWith(color: AppColors.black),
        ),
      ],
    );
  }
}
