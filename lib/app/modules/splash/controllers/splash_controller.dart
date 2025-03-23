import 'package:get/get.dart';
import 'package:new_ics/app/common/app_toasts.dart';
import 'package:new_ics/app/routes/app_pages.dart';
import 'package:new_ics/app/utils/auth_util.dart';
import 'package:new_ics/app/utils/constants.dart';
import 'package:new_ics/gen/assets.gen.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashController extends GetxController {
  final String splasehimage = Assets.logos.logo2.path;

  @override
  void onInit() {
    checkIfSignedIn();
    super.onInit();
  }

  waitAndNavigate() async {
    bool hasShownToast = false;

    while (true) {
      await Future.delayed(const Duration(seconds: 1));

      final notificationPermissionStatus =
          await requestNotificationPermission();

      if (notificationPermissionStatus == PermissionStatus.granted) {
        checkIfSignedIn();
        break;
      } else {
        if (!hasShownToast) {
          AppToasts.showError("Please Enable Permissions".tr);
          await openAppSettings();
          hasShownToast = true;
        }
      }
    }
  }

  Future<PermissionStatus> requestNotificationPermission() async {
    final status = await Permission.notification.request();
    return status;
  }

  void checkIfSignedIn() async {
    final accessToken = await AuthUtil().getAccessToken();
    if (accessToken != null) {
      print(accessToken);
      final isPhoneVerified = await AuthUtil().isUserPhoneVerified();
      if (isPhoneVerified) {
        Future.delayed(const Duration(seconds: 1), () {
          Get.toNamed(Routes.MAIN_PAGE);
        });
      } else {
        Future.delayed(const Duration(seconds: 1), () {
          Get.toNamed(Routes.ON_BORDING);
        });
      }
    } else {
      Future.delayed(const Duration(seconds: 1), () {
        Get.toNamed(Routes.ON_BORDING);
      });
    }
  }
}
