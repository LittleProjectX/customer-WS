import 'package:get/get.dart';

import '../controllers/viewimage_controller.dart';

class ViewimageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ViewimageController>(
      () => ViewimageController(),
    );
  }
}
