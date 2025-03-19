import 'package:get/get.dart';

import '../controllers/new_residence_controller.dart';

class NewResidenceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewResidenceController>(
      () => NewResidenceController(),
    );
  }
}
