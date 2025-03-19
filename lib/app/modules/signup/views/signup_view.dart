import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_ics/app/common/appbar/customappbar.dart';
import 'package:new_ics/app/common/button/button_primary_fill.dart';
import 'package:new_ics/app/common/forms/phone_number_input.dart';
import 'package:new_ics/app/common/forms/text_input.dart';
import 'package:new_ics/app/common/forms/text_input_signup.dart';
import 'package:new_ics/app/common/loading/custom_loading_widget.dart';
import 'package:new_ics/app/data/enums.dart';
import 'package:new_ics/app/routes/app_pages.dart';
import 'package:new_ics/app/theme/app_assets.dart';
import 'package:new_ics/app/theme/app_colors.dart';
import 'package:new_ics/app/theme/app_sizes.dart';
import 'package:new_ics/app/theme/app_text_styles.dart';
import 'package:new_ics/app/utils/validator_util.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'ICS'.tr,
        title2: "Sign Up".tr,
        showLeading: true,
      ),
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSizes.mp_w_4,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [_buildHeaderImage(), _buildSignupForm()],
                      ),
                    ),
                  ),
                ),
                _buildFooterButtons(),
              ],
            ),
          ),
          Obx(
            () =>
                controller.networkStatus.value == NetworkStatus.LOADING
                    ? CustomLoadingWidget()
                    : SizedBox(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderImage() {
    return Align(
      alignment: Alignment.center,
      child: Image.asset(
        AppAssets.splasehimage2,
        height: 13.h,
        width: 80.w,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildSignupForm() {
    return Card(
      elevation: 4,
      color: AppColors.whiteOff,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(AppSizes.mp_w_4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Create an account".tr,
              textAlign: TextAlign.start,
              style: AppTextStyles.displayOneBold.copyWith(
                fontSize: AppSizes.font_14,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: AppSizes.mp_v_1),
            Form(
              key: controller.regFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFirstNameInput(),
                  SizedBox(height: 2.h),
                  _buildLastNameInput(),
                  SizedBox(height: 2.h),
                  _buildPhoneInput(),
                  SizedBox(height: 2.h),
                  _buildEmailInput(),
                  SizedBox(height: 2.h),
                  _buildPinInput(),
                  SizedBox(height: 2.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooterButtons() {
    return Column(
      children: [
        Obx(
          () => SizedBox(
            height:
                controller.isNextPressed.value ||
                        controller.passwordController.text.isNotEmpty
                    ? 0.0
                    : 5.h,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.mp_w_4,
            vertical: AppSizes.mp_w_2,
          ),
          child: Column(children: [_buildNextButton(), _buildSignupButton()]),
        ),
      ],
    );
  }

  Widget _buildPinInput() {
    return TextInputSignup(
      hint: 'Pin'.tr,
      maxLength: 6,
      moreInstructions: ["Maximum  6 digits".tr, "Only Numbers".tr],
      keyboardType: TextInputType.number,
      isPassword: true,
      onChanged: (value) {
        bool isValid = controller.validatePassword();
        controller.isPasswordValid.value = isValid;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your pin'.tr;
        }
        if (!controller.isPasswordValid.value) {
          return 'Pin must be 6'.tr;
        }
        return null;
      },
      controller: controller.passwordController,
      autofocus: controller.isNextPressed.value,
      focusNode: controller.passwordFocusNode,
    );
  }

  Widget _buildCountryCodePicker() {
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
        controller.isEthiopia.value = element.code == 'ET';
      },
      initialSelection: 'et',
      textOverflow: TextOverflow.fade,
      showCountryOnly: false,
      showOnlyCountryWhenClosed: false,
      alignLeft: false,
    );
  }

  Widget _buildPhoneNumberInput() {
    return PhoneNumberInput(
      isMandatory: true,
      hint: 'Phone numbers'.tr,
      labelText: "Phone number".tr,
      focusNode: controller.phoneFocusNode,
      autofocus: false,
      controller: controller.phoneController,
      onChanged: (value) {
        bool isValid = ValidatorUtil.isPhoneValidEthiopian(value);
        controller.isPhoneValid.value = isValid;
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Phone number is required'.tr;
        }
        return null;
      },
    );
  }

  Widget _buildNextButton() {
    return Column(
      children: [
        Obx(
          () => Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.mp_w_8),
            child: ButtonPrimaryFill(
              isterms: false,
              buttonSizeType: ButtonSizeType.LARGE,
              isDisabled:
                  !controller.isPasswordValid.value ||
                  !controller.isPhoneValid.value,
              text: "Next".tr,
              onTap: () async {
                if (controller.regFormKey.currentState!.validate()) {
                  if (!controller.isPasswordValid.value ||
                      !controller.isPhoneValid.value) {
                    // Show an error message or perform some action
                  } else {
                    controller.signUp();
                  }
                }
              },
            ),
          ),
        ),
        SizedBox(height: 2.h),
      ],
    );
  }

  Widget _buildPhoneInput() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCountryCodePicker(),
        SizedBox(width: AppSizes.mp_w_4),
        Expanded(child: _buildPhoneNumberInput()),
      ],
    );
  }

  Widget _buildLastNameInput() {
    return TextInputAll(
      isMandatory: true,
      textInputAction: TextInputAction.next,
      controller: controller.lNameController,
      hint: 'Last name'.tr,
      showClearButton: false,
      onChanged: (value) {
        bool isValid = controller.validateusername();
        controller.isUsernameCorrect.value = isValid;
      },
    );
  }

  Widget _buildFirstNameInput() {
    return TextInputAll(
      isMandatory: true,
      controller: controller.fNameController,
      hint: 'First name'.tr,
      textInputAction: TextInputAction.next,
      showClearButton: false,
      autoFocus: false,
      onChanged: (value) {
        bool isValid = controller.validateusername();
        controller.isUsernameCorrect.value = isValid;
      },
    );
  }

  Widget _buildEmailInput() {
    return Obx(
      () => TextInputAll(
        enabled: controller.isPhoneValid.value != false ? true : false,
        isMandatory: !controller.isEthiopia.value,
        controller: controller.emailController,
        hint: 'Email'.tr,
        textInputAction: TextInputAction.next,
        showClearButton: false,
        autoFocus: false,
        onChanged: (value) {
          bool isValid = controller.validateEmail();
          controller.isEmailValid.value = isValid;
        },
        validator: (value) {
          if (controller.isEthiopia.value) {
            return null; // No validation for Ethiopia
          }
          if (value == null || value.isEmpty) {
            return 'Email is required'.tr;
          }
          if (!controller.isEmailValid.value) {
            return 'Invalid email address'.tr;
          }
          return null;
        },
      ),
    );
  }

  Widget _buildSignupButton() {
    return MaterialButton(
      onPressed: () {
        Get.toNamed(Routes.LOGIN);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Already have an account?".tr,
            style: AppTextStyles.bodySmallRegular.copyWith(
              color: AppColors.black,
            ),
          ),
          Text(
            " Log in".tr,
            style: AppTextStyles.bodySmallRegular.copyWith(
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
