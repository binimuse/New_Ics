import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:new_ics/app/common/appbar/customappbar.dart';
import 'package:new_ics/app/common/button/button_primary_fill_login.dart';
import 'package:new_ics/app/common/forms/phone_number_input.dart';
import 'package:new_ics/app/common/loading/custom_loading_widget.dart';
import 'package:new_ics/app/data/enums.dart';
import 'package:new_ics/app/routes/app_pages.dart';
import 'package:new_ics/app/theme/app_assets.dart';
import 'package:new_ics/app/theme/app_colors.dart';
import 'package:new_ics/app/theme/app_sizes.dart';
import 'package:new_ics/app/theme/app_text_styles.dart';
import 'package:new_ics/app/utils/validator_util.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();

        return false;
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'ICS'.tr,
          title2: "Forgot Password".tr,
          showLeading: true,
        ),
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    AppAssets.splasehimage2,
                    height: 13.h,
                    width: 80.w,
                    fit: BoxFit.contain,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Form(
                        key: controller.forgotFormKey,
                        child: Column(
                          children: [
                            Card(
                              color: AppColors.whiteOff,
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(AppSizes.mp_w_4),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Forgot Password".tr,
                                      textAlign: TextAlign.start,
                                      style: AppTextStyles.displayOneBold
                                          .copyWith(
                                            fontSize: AppSizes.font_14,
                                            color: AppColors.primary,
                                          ),
                                    ),
                                    SizedBox(height: AppSizes.mp_v_1),
                                    Text(
                                      "we will send a verification code to your registered phone."
                                          .tr,
                                      textAlign: TextAlign.start,
                                      style: AppTextStyles.bodySmallRegular
                                          .copyWith(
                                            color: AppColors.grayDark,
                                            fontSize: AppSizes.font_12,
                                          ),
                                    ),
                                    SizedBox(height: AppSizes.mp_v_4),
                                    buildPhoneinput(),
                                    SizedBox(height: 1.h),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height:
                          controller.isNextPressed.value ||
                                  controller.passwordController.text.isNotEmpty
                              ? 0.0
                              : 5.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSizes.mp_w_4,
                        vertical: AppSizes.mp_w_2,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: buildButton(context),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              buildSignupButton(),
                              SizedBox(
                                height: 2.h,
                                child: VerticalDivider(
                                  color: AppColors.secondary,
                                  thickness: 2,
                                ),
                              ),
                              buildFindPassswordButton(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Obx(
              () =>
                  controller.networkStatus.value == NetworkStatus.LOADING
                      ? CustomLoadingWidget()
                      : SizedBox(),
            ),
          ],
        ),
      ),
    );
  }

  buildCountryCode() {
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
      initialSelection: 'et',
      textOverflow: TextOverflow.fade,
      showCountryOnly: false,
      showOnlyCountryWhenClosed: false,
      alignLeft: false,
    );
  }

  buildPhonenumber() {
    return Expanded(
      child: PhoneNumberInput(
        isMandatory: true,
        hint: 'Phone number'.tr,
        labelText: "Phone number".tr,
        focusNode: controller.phoneFocusNode,
        autofocus: false,
        controller: controller.phoneController,
        onChanged: (value) {
          bool isValid = ValidatorUtil.validatPhone(value);
          controller.isPhoneValid.value = isValid;
        },
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter your Phone Number'.tr;
          }
          if (!controller.isPhoneValid.value) {
            return 'Invalid phone number'.tr;
          }
          return null;
        },
      ),
    );
  }

  buildPhoneinput() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildCountryCode(),
        SizedBox(width: AppSizes.mp_w_4),
        buildPhonenumber(),
      ],
    );
  }

  buildSignupButton() {
    return MaterialButton(
      onPressed: () {
        Get.toNamed(Routes.SIGNUP);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.h),
        child: Center(
          child: Text(
            "Sign up".tr,
            style: AppTextStyles.bodySmallUnderlineRegular.copyWith(
              color: AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }

  buildFindPassswordButton() {
    return MaterialButton(
      onPressed: () {
        Get.toNamed(Routes.FORGOT_PASSWORD);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.h),
        child: Center(
          child: Text(
            "Find Pin".tr,
            style: AppTextStyles.bodySmallUnderlineRegular.copyWith(
              color: AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }

  buildButton(BuildContext context) {
    var countryCode = "+251";
    return Obx(() {
      final isPhoneNumberValid = controller.isPhoneValid.value;

      String buttonText;
      Color buttonColor;
      bool isDisabled = !isPhoneNumberValid;

      if (isPhoneNumberValid) {
        buttonText = "Send OTP".tr;
        buttonColor = AppColors.primary;
      } else {
        buttonText = "Enter your phone number".tr;
        buttonColor = AppColors.grayLight;
      }

      return ButtonPrimaryFillLogin(
        buttonSizeType: ButtonSizeTypeLogin.MEDIUM,
        isDisabled: isDisabled,
        buttonColor: buttonColor,
        text: buttonText,
        onTap: () {
          if (isPhoneNumberValid) {
            // controller.sendOtp(context);
            Get.toNamed(
              Routes.OTP_VARIFICATION,
              arguments: {
                "phone":
                    countryCode.toString() + controller.phoneController.text,
                "isFromForgot": true,
              },
            ); // Navigate to OTP page
          }
        },
      );
    });
  }
}
