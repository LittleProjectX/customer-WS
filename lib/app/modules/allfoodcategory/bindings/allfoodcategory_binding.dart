import 'package:get/get.dart';

import '../controllers/allfoodcategory_controller.dart';

class AllfoodcategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllfoodcategoryController>(
      () => AllfoodcategoryController(),
    );
  }
}
