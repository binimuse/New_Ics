import 'package:get/get.dart';

import '../controllers/visa_extantion_controller.dart';

class VisaExtantionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VisaExtantionController>(
      () => VisaExtantionController(),
    );
  }
}
