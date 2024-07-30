import 'package:get/get.dart';

import '../controllers/edituser_controller.dart';

class EdituserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EdituserController>(
      () => EdituserController(),
    );
  }
}
