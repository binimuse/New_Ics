import 'package:get/get.dart';

import '../controllers/visa_cancellation_controller.dart';

class VisaCancellationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VisaCancellationController>(
      () => VisaCancellationController(),
    );
  }
}
