import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserinfoController extends GetxController {
  late TextEditingController name;

  @override
  void onInit() {
    name = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    name.dispose();
    super.dispose();
  }
}
