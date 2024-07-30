import 'package:get/get.dart';

import '../controllers/imagetranf_controller.dart';

class ImagetranfBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ImagetranfController>(
      () => ImagetranfController(),
    );
  }
}
