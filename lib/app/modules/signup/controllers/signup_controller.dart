import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_ics/app/common/app_toasts.dart';
import 'package:new_ics/app/data/enums.dart';
import 'package:new_ics/app/data/models/login/sign_up.dart';
import 'package:new_ics/app/data/services/module_login_signup_service.dart';
import 'package:new_ics/app/routes/app_pages.dart';
import 'package:new_ics/app/utils/dio_util.dart';

class SignupController extends GetxController {
  Rx<NetworkStatus> networkStatus = Rx(NetworkStatus.IDLE);
  final loginFormKey = GlobalKey<FormState>();
  final phoneFocusNode = FocusNode();
  var isPhoneValid = false.obs;
  var isPasswordValid = false.obs;
  late TextEditingController emailController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> regFormKey = GlobalKey<FormState>();
  //usernmae
  late TextEditingController fNameController = TextEditingController();
  late TextEditingController lNameController = TextEditingController();
  late TextEditingController phoneController = TextEditingController();
  var isNextPressed = false.obs;
  final FocusNode passwordFocusNode = FocusNode(); // Added password focus node
  var isEthiopia = true.obs;

  var countryCode = "+251";
  @override
  void onInit() {
    super.onInit();

    emailController = TextEditingController();
    passwordController = TextEditingController();

    fNameController = TextEditingController();
    lNameController = TextEditingController();

    phoneController = TextEditingController();
    // getConfigration();
    phoneController.addListener(() {
      if (phoneController.text.startsWith('0')) {
        phoneController.text = phoneController.text.substring(1);
      }
    });
  }

  var isEmailValid = false.obs;
  bool validateEmail() {
    final email = emailController.text;
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(pattern);
    if (regex.hasMatch(email)) {
      isEmailValid(true);
      return true;
    } else {
      isEmailValid(false);
      return false;
    }
  }

  bool validatePassword() {
    final password = passwordController.text;
    bool hasNumber = false;

    if (password.length >= 6) {
      for (int i = 0; i < password.length; i++) {
        if (password[i].isNumericOnly) {
          hasNumber = true;
        }
      }

      if (hasNumber) {
        isPasswordValid(true);
        return true;
      }
    }

    isPasswordValid(false);
    return false;
  }

  var isUsernameCorrect = false.obs;
  bool validateusername() {
    if (fNameController.text.isNotEmpty && lNameController.text.isNotEmpty) {
      isUsernameCorrect.value = true;
      return true;
    } else {
      isUsernameCorrect.value = false;
      return false;
    }
  }

  void checkReg() {
    if (!loginFormKey.currentState!.validate()) return;
    signUp();
  }

  signUp() async {
    ///CHANGE NETWORK STATUS
    networkStatus.value = NetworkStatus.LOADING;

    try {
      String phoneNumber = phoneController.text;

      if (phoneNumber.startsWith("0")) {
        //  print("phone number starts with 0");

        phoneNumber = phoneNumber.substring(1);
      }
      SignUpResponse signInResponse = await LoginSignupService(
        DioUtil().getDio(),
      ).signUp(
        signUpRequest: SignUpRequest(
          phone_number: "+251$phoneNumber",
          password: passwordController.text,
          name: "${fNameController.text} ${lNameController.text}",
        ),
      );

      Get.toNamed(
        Routes.OTP_VARIFICATION,
        arguments: {
          "phone": countryCode.toString() + phoneController.text,
          "isFromForgot": false,
        },
      );
    } catch (e) {
      networkStatus.value = NetworkStatus.ERROR;
      AppToasts.showError(e.toString());
      if (e is DioException) {
        final response = e.response;
        if (response != null && response.data is Map) {
          final data = response.data;
          final message =
              data.containsKey("errors") ? data["errors"] : data["message"];
          if (message is Map && message.containsKey("message")) {
            AppToasts.showError(
              message["message"].toString(),
            ); // Show "Operator Account Banned!" message
          } else {
            AppToasts.showError(message.toString());
          }
        }
      }
    }
  }
}
