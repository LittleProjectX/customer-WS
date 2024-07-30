import 'package:get/get.dart';

import '../controllers/tambahan_controller.dart';

class TambahanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TambahanController>(
      () => TambahanController(),
    );
  }
}
