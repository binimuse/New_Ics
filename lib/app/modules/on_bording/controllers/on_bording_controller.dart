import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:new_ics/app/common/app_toasts.dart';
import 'package:new_ics/app/data/enums.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:new_ics/app/routes/app_pages.dart';

class OnBordingController extends GetxController {
  final RxBool isLightTheme = false.obs;

  var isApiLoading = false.obs;
  var hasNetworkError = false.obs;
  var isoptional = true.obs;
  var appversion = "".obs;
  var currentSlide = 0.obs;

  /// List of titles for the on-boarding slides.
  List<String> titles = [
    'Make a Profile'.tr,
    'Fill out the Application'.tr,
    'Have your document delivered'.tr,
  ]; // Add or change this based on your requirement

  @override
  void onInit() {
    super.onInit();

    pageController = PageController();
  }

  late PageController pageController;
  int currentIndex = 0;

  /// Function called when the current slide is changed.
  onChangedFunction(int index) {
    currentIndex = index;
  }

  Rx<NetworkStatus> networkStatus = Rx(NetworkStatus.IDLE);

  Future<void> navigateToLogin() async {
    networkStatus.value = NetworkStatus.LOADING;
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // Show a dialog or a snackbar indicating no internet connection
      AppToasts.showError('No internet connection'.tr);
      networkStatus.value = NetworkStatus.ERROR;
      return;
    }

    await Future.delayed(const Duration(milliseconds: 400));
    networkStatus.value = NetworkStatus.SUCCESS;
    Get.toNamed(Routes.LOGIN);
  }
}
