import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  late TextEditingController phone;
  late TextEditingController password;

  @override
  void onInit() {
    phone = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    phone.dispose();
    password.dispose();
    super.dispose();
  }
}
