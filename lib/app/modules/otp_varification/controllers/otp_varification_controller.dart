import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:new_ics/app/common/app_toasts.dart';
import 'package:new_ics/app/data/enums.dart';
import 'package:new_ics/app/data/models/login/resend_otp.dart';
import 'package:new_ics/app/data/models/login/verify_otp.dart';
import 'package:new_ics/app/data/services/module_login_signup_service.dart';
import 'package:new_ics/app/routes/app_pages.dart';
import 'package:new_ics/app/utils/dio_util.dart';

class OtpVarificationController extends GetxController {
  var phonenumber = "".obs;
  RxBool isFromForgot = false.obs;

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    otpController = TextEditingController();
    isjustForinit(true);
    isFromForgot.value = Get.arguments["isFromForgot"];
    phonenumber.value = Get.arguments["phone"];
  }

  @override
  void onReady() {
    super.onReady();
  }

  Rx<NetworkStatus> networkStatus = Rx(NetworkStatus.IDLE);
  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  //mobile varification

  FocusNode otpFocusNode = FocusNode();
  TextEditingController otpController = TextEditingController();
  List<TextEditingController> otpControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );

  var isNextPressedMobile = false.obs;
  var isOtpValid = false.obs;
  var isjustForinit = false.obs;
  var resendotpstarted = false.obs;
  var makeButtonEnable = true.obs;

  var countdownValue = 60.obs;
  Timer? countdownTimer;

  @override
  void dispose() {
    countdownTimer?.cancel();
    super.dispose();
  }

  void startCountdown() {
    countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      countdownValue--;

      if (countdownValue == 0) {
        timer.cancel();
        makeButtonEnable(true);
      }
    });
  }

  Future<void> resendOtp() async {
    networkStatus.value = NetworkStatus.LOADING;
    try {
      var response = await LoginSignupService(DioUtil().getDio()).resendOTP(
        resendRequest: ResendRequest(phone_number: phonenumber.value),
      );
      if (response.message == "OTP sent successfully") {
        networkStatus.value = NetworkStatus.SUCCESS;
        AppToasts.showSuccess("OTP resent".tr);
        makeButtonEnable(false);
        countdownValue.value = 60;
        startCountdown();
      } else {
        networkStatus.value = NetworkStatus.ERROR;
        AppToasts.showError(response.message ?? "Something went wrong".tr);
      }
    } catch (e) {
      networkStatus.value = NetworkStatus.ERROR;
      AppToasts.showError("An error occurred while resending OTP".tr);
    }
  }

  var otp = "".obs;
  var verificationOtp = false.obs;
  Future<void> verification() async {
    if (isFromForgot.value) {
      verifyOtp();
    } else {
      networkStatus.value = NetworkStatus.LOADING;
      verificationOtp(true);

      try {
        var response = await LoginSignupService(DioUtil().getDio()).verifyOTP(
          verifyRequest: VerifyRequest(
            phone_number: phonenumber.value,
            otp: otp.value,
          ),
        );
        if (response.message == "Account Verified!") {
          networkStatus.value = NetworkStatus.SUCCESS;
          verificationOtp(false);
          AppToasts.showSuccess("Otp verified successfully".tr);
          Future.delayed(const Duration(milliseconds: 100), () {
            Get.offAllNamed(Routes.LOGIN);
          });
        } else {
          networkStatus.value = NetworkStatus.ERROR;
          verificationOtp(false);
          AppToasts.showError(response.message ?? "Invalid OTP".tr);
        }
      } catch (e) {
        networkStatus.value = NetworkStatus.ERROR;
        verificationOtp(false);
        AppToasts.showError("An error occurred during OTP verification".tr);
      }
    }
  }

  void verifyOtp() {
    Get.toNamed(Routes.RESET_PASSWORD, arguments: {"phone": phonenumber.value});
  }
}
