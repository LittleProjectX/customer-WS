import 'package:get/get.dart';

import '../controllers/userinfo_controller.dart';

class UserinfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserinfoController>(
      () => UserinfoController(),
    );
  }
}
