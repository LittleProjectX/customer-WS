import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EdituserController extends GetxController {
  late TextEditingController name;
  late TextEditingController phone;

  @override
  void onInit() {
    name = TextEditingController();
    phone = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    name.dispose();
    phone.dispose();
    super.dispose();
  }
}
