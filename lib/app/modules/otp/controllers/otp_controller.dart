import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  late TextEditingController otp;

  @override
  void onInit() {
    otp = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    otp.dispose();
    super.dispose();
  }
}
