// ignore_for_file: deprecated_member_use

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_ics/app/common/appbar/customappbar.dart';
import 'package:new_ics/app/common/button/button_primary_fill_login.dart';
import 'package:new_ics/app/common/forms/phone_number_input.dart';
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
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

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
          title2: "Login".tr,
          showLeading: true,
        ),
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Form(
                        key: controller.regFormKey,
                        child: Column(
                          children: [buildLogo(), buildLoginCard()],
                        ),
                      ),
                    ),
                  ),
                ),
                buildBottomSection(context),
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

  Widget buildLogo() {
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

  Widget buildLoginCard() {
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
              "LOGIN".tr,
              textAlign: TextAlign.start,
              style: AppTextStyles.displayOneBold.copyWith(
                fontSize: AppSizes.font_14,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: AppSizes.mp_v_1),
            buildSignInWithEmailButton(),
            SizedBox(height: AppSizes.mp_v_4),
            Obx(
              () =>
                  controller.isEmailSignIn.value
                      ? buildEmailInput()
                      : buildPhoneInput(),
            ),
            SizedBox(height: 1.h),
            Obx(
              () =>
                  controller.isNextPressed.value ||
                          controller.passwordController.text.isNotEmpty
                      ? buildPasswordInput()
                      : SizedBox(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPasswordInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 19.0),
      child: TextInputSignup(
        hint: 'Password'.tr,
        moreInstructions: [
          "Minimum 6 characters".tr,
          "Include letters and numbers".tr,
        ],
        keyboardType: TextInputType.text,
        isPassword: true,
        onChanged: (value) {
          bool isValid = controller.validatePassword();
          controller.isPasswordValid.value = isValid;
        },
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter your password'.tr;
          }
          if (value.length < 6) {
            return 'Password must be at least 6 characters'.tr;
          }
          if (!controller.isPasswordValid.value) {
            return 'Invalid password'.tr;
          }
          return null;
        },
        controller: controller.passwordController,
        autofocus: false,
        focusNode: controller.passwordFocusNode,
      ),
    );
  }

  Widget buildBottomSection(BuildContext context) {
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
          child: Column(
            children: [
              Obx(
                () => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: buildButton(context),
                ),
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
                  buildFindPasswordButton(),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildCountryCode() {
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

  Widget buildPhoneNumber() {
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

  Widget buildPhoneInput() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildCountryCode(),
        SizedBox(width: AppSizes.mp_w_4),
        buildPhoneNumber(),
      ],
    );
  }

  Widget buildPinInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 19.0),
      child: TextInputSignup(
        hint: 'Pin'.tr,
        moreInstructions: ["Minimum 6 digits".tr, "Only Numbers".tr],
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
          if (value.length < 6) {
            return 'Pin must be at least 6 digits'.tr;
          }
          if (!controller.isPasswordValid.value) {
            return 'Invalid pin'.tr;
          }
          return null;
        },
        controller: controller.passwordController,
        autofocus: false,
        focusNode: controller.passwordFocusNode,
      ),
    );
  }

  Widget buildSignInWithEmailButton() {
    return Obx(
      () => MaterialButton(
        onPressed: () {
          if (controller.isEmailSignIn.value) {
            controller.isEmailSignIn(false);
            controller.isNextPressed(false);
            controller.emailController.clear();
            controller.passwordController.clear();
          } else {
            controller.isEmailSignIn(true);
            controller.isNextPressed(false);
            controller.phoneController.clear();
            controller.passwordController.clear();
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 1.h),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
                child: Text(
                  controller.isEmailSignIn.value
                      ? "Sign in With Phone".tr
                      : "Sign in With your Email address".tr,
                  style: AppTextStyles.bodySmallRegular.copyWith(
                    color: AppColors.primary,
                    fontSize: AppSizes.font_12,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildEmailInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 19.0),
      child: TextInputSignup(
        hint: 'Email'.tr,
        keyboardType: TextInputType.emailAddress,
        isPassword: false,
        onChanged: (value) {
          bool isValid = controller.validateEmail();
          controller.isEmailValid.value = isValid;
        },
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter your email'.tr;
          }
          if (!controller.isEmailValid.value) {
            return 'Invalid email'.tr;
          }
          return null;
        },
        controller: controller.emailController,
        autofocus: false,
        focusNode: controller.emailFocusNode,
      ),
    );
  }

  Widget buildSignupButton() {
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

  Widget buildFindPasswordButton() {
    return MaterialButton(
      onPressed: () {
        Get.toNamed(Routes.FORGOT_PASSWORD);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.h),
        child: Center(
          child: Text(
            "Find Password".tr,
            style: AppTextStyles.bodySmallUnderlineRegular.copyWith(
              color: AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildButton(BuildContext context) {
    final isPhoneNumberValid = controller.isPhoneValid.value;
    final isEmailValid = controller.isEmailValid.value;
    final isNextPressed = controller.isNextPressed.value;
    final isPasswordValid = controller.isPasswordValid.value;

    late Color buttonColors;
    bool isDisabled;
    String buttonText;

    if (controller.isEmailSignIn.value) {
      isDisabled = !isEmailValid || !isPasswordValid;
      if (isEmailValid) {
        if (isNextPressed) {
          if (isPasswordValid) {
            buttonText = "Log in".tr;
            buttonColors = AppColors.primary;
          } else {
            buttonText = "Enter Password".tr;
            buttonColors = AppColors.grayLight;
          }
        } else {
          buttonText = "Next".tr;
          buttonColors = AppColors.black;
        }
      } else {
        buttonText = "Enter Email".tr;
        buttonColors = AppColors.grayLight;
      }
    } else {
      isDisabled =
          (!isPhoneNumberValid && !isPasswordValid) ||
          (isPhoneNumberValid && !isNextPressed && !isPasswordValid);
      if (isPhoneNumberValid) {
        if (isNextPressed) {
          if (isPasswordValid) {
            buttonText = "Log in".tr;
            buttonColors = AppColors.primary;
          } else {
            buttonText = "Enter Pin".tr;
            buttonColors = AppColors.grayLight;
          }
        } else {
          if (isPasswordValid) {
            buttonText = "Log in".tr;
            buttonColors = AppColors.primary;
          } else {
            buttonText = "Next".tr;
            buttonColors = AppColors.black;
          }
        }
      } else {
        if (isPasswordValid) {
          buttonText = "Log in".tr;
          buttonColors = AppColors.grayLight;
        } else {
          buttonText = "Enter your phone number".tr;
          buttonColors = AppColors.grayLight;
        }
      }
    }

    return MouseRegion(
      onEnter: (_) {
        if (!isDisabled) {
          buttonColors = AppColors.primaryDark;
        }
      },
      onExit: (_) {
        if (!isDisabled) {
          buttonColors = AppColors.primary;
        }
      },
      child: ButtonPrimaryFillLogin(
        buttonSizeType: ButtonSizeTypeLogin.MEDIUM,
        isDisabled: isDisabled,
        buttonColor: buttonColors,
        text: buttonText,
        onTap: () {
          if (controller.isEmailSignIn.value) {
            if (isEmailValid && !isNextPressed) {
              controller.isNextPressed(true);
              Future.delayed(const Duration(milliseconds: 100), () {
                FocusScope.of(
                  context,
                ).requestFocus(controller.passwordFocusNode);
              });
            } else if (isEmailValid && isPasswordValid) {
              controller.signIn(context);
            }
          } else {
            if (isPhoneNumberValid && !isNextPressed) {
              controller.isNextPressed(true);
              Future.delayed(const Duration(milliseconds: 100), () {
                FocusScope.of(
                  context,
                ).requestFocus(controller.passwordFocusNode);
              });
            } else if (isPhoneNumberValid && isPasswordValid) {
              controller.signIn(context);
            }
          }
        },
      ),
    );
  }
}
