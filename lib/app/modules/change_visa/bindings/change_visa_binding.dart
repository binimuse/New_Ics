import 'package:get/get.dart';

import '../controllers/change_visa_controller.dart';

class ChangeVisaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangeVisaController>(
      () => ChangeVisaController(),
    );
  }
}
