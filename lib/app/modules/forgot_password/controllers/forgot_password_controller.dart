import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:new_ics/app/data/enums.dart';

class ForgotPasswordController extends GetxController {
  late TextEditingController emailController = TextEditingController();
  final emailFocusNode = FocusNode();
  final GlobalKey<FormState> forgotFormKey = GlobalKey<FormState>();

  var isNextPressed = false.obs;
  var isPasswordValid = false.obs;
  late TextEditingController passwordController = TextEditingController();
  final FocusNode passwordFocusNode = FocusNode(); // Added password focus node
  var signingIn = false.obs;
  var countryCode = "+251";
  late TextEditingController phoneController = TextEditingController();
  Rx<NetworkStatus> networkStatus = Rx(NetworkStatus.IDLE);
  final phoneFocusNode = FocusNode();
  var isPhoneValid = false.obs;

  @override
  void onInit() {
    super.onInit();
    phoneController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  bool validatePhone() {
    final phone = phoneController.text;
    if (phone.length >= 8) {
      isPhoneValid(true);
      return true;
    } else {
      isPhoneValid(false);
      return false;
    }
  }

  // bool validateEmail() {
  //   final email = emailController.text;
  //   String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  //   RegExp regex = RegExp(pattern);
  //   if (regex.hasMatch(email)) {
  //     isEmailValid(true);
  //     return true;
  //   } else {
  //     isEmailValid(false);
  //     return false;
  //   }
  // }

  // Future<void> sendOtp(BuildContext context) async {
  //   networkStatus.value = NetworkStatus.LOADING;
  //   try {
  //     var response = await LoginSignupService(
  //       DioUtil().getDio(),
  //     ).sendOtp(phoneNumber: phoneController.text, email: emailController.text);
  //     if (response.success) {
  //       networkStatus.value = NetworkStatus.SUCCESS;
  //       AppToasts.showSuccess("OTP sent successfully".tr);
  //       // Navigate to OTP verification screen
  //       Get.toNamed(
  //         Routes.OTP_VARIFICATION,
  //         arguments: {
  //           "phone": countryCode + phoneController.text,
  //           "isFromForgot": true,
  //         },
  //       );
  //     } else {
  //       networkStatus.value = NetworkStatus.ERROR;
  //       AppToasts.showError(response.message ?? "Failed to send OTP".tr);
  //     }
  //   } catch (e) {
  //     networkStatus.value = NetworkStatus.ERROR;
  //     AppToasts.showError("An error occurred while sending OTP".tr);
  //   }
  // }
}
