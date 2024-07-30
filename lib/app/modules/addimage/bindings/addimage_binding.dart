import 'package:get/get.dart';

import '../controllers/addimage_controller.dart';

class AddimageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddimageController>(
      () => AddimageController(),
    );
  }
}
