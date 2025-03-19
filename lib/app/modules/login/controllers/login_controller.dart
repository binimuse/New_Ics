import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_ics/app/common/app_toasts.dart';
import 'package:new_ics/app/data/enums.dart';
import 'package:new_ics/app/data/models/login/sign_in.dart';
import 'package:new_ics/app/data/services/module_login_signup_service.dart';
import 'package:new_ics/app/routes/app_pages.dart';
import 'package:new_ics/app/utils/auth_util.dart';
import 'package:new_ics/app/utils/dio_util.dart';

class LoginController extends GetxController {
  final count = 0.obs;
  late TextEditingController emailController;
  final emailFocusNode = FocusNode();
  final GlobalKey<FormState> regFormKey = GlobalKey<FormState>();
  var isNextPressed = false.obs;
  var isPasswordValid = false.obs;
  var isEmailValid = false.obs;
  late TextEditingController passwordController;
  final FocusNode passwordFocusNode = FocusNode();
  var signingIn = false.obs;
  var isEmailSignIn = false.obs;
  var countryCode = "+251";
  late TextEditingController phoneController;
  final phoneFocusNode = FocusNode();
  var isPhoneValid = false.obs;
  Rx<NetworkStatus> networkStatus = Rx(NetworkStatus.IDLE);

  @override
  void onInit() {
    super.onInit();
    phoneController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    phoneController.addListener(_removeLeadingZero);
  }

  void _removeLeadingZero() {
    if (phoneController.text.startsWith('0')) {
      phoneController.text = phoneController.text.substring(1);
    }
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
    bool hasNumber = password.contains(RegExp(r'\d'));
    if (password.length >= 6 && hasNumber) {
      isPasswordValid(true);
      return true;
    } else {
      isPasswordValid(false);
      return false;
    }
  }

  Future<void> signIn(BuildContext context) async {
    _setLoadingState();
    try {
      String phoneNumber = _formatPhoneNumber(phoneController.text);
      SignInResponse signInResponse = await _attemptSignIn(phoneNumber);
      await _handleSignInResponse(signInResponse);
    } catch (e, s) {
      print(e);
      print(s);
      _handleException(e, s);
    }
  }

  String _formatPhoneNumber(String phoneNumber) {
    if (phoneNumber.startsWith("0")) {
      phoneNumber = phoneNumber.substring(1);
    }
    return "+251$phoneNumber";
  }

  Future<SignInResponse> _attemptSignIn(String phoneNumber) {
    return LoginSignupService(DioUtil().getDio()).signIn(
      signInRequest: SignInRequest(
        phone_number: phoneNumber,
        password: passwordController.text,
      ),
    );
  }

  Future<void> _handleSignInResponse(SignInResponse signInResponse) async {
    await AuthUtil().saveTokenAndUserInfo(
      accessToken: signInResponse.accessToken,
      refreshToken: signInResponse.refreshToken,
      user: signInResponse.user.toJson(),
    );
    networkStatus.value = NetworkStatus.SUCCESS;
    Get.offAndToNamed(Routes.MAIN_PAGE);
  }

  void _handleException(dynamic e, StackTrace s) {
    networkStatus.value = NetworkStatus.ERROR;
    signingIn(false);
    if (e is SocketException) {
      AppToasts.showError("No connection found".tr);
    } else if (e is DioException) {
      _handleDioException(e);
    } else {
      AppToasts.showError("An error occurred during sign in".tr);
    }
  }

  void _handleDioException(DioException e) {
    final response = e.response;
    if (response != null && response.data is Map) {
      final data = response.data;
      final message =
          data.containsKey("errors") ? data["errors"] : data["message"];
      if (message is Map && message.containsKey("message")) {
        AppToasts.showError(message["message"].toString());
      } else {
        if (message == "Phone number is not verified") {
          AppToasts.showError(message.toString());
          Get.toNamed(
            Routes.OTP_VARIFICATION,
            arguments: {
              "phone": countryCode.toString() + phoneController.text,
              "isFromForgot": false,
            },
          );
        }
      }
    }
  }

  void _setLoadingState() {
    networkStatus.value = NetworkStatus.LOADING;
    signingIn(true);
  }
}
