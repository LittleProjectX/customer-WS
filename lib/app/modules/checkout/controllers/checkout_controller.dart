import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  late TextEditingController alamat;
  late TextEditingController pesan;

  @override
  void onInit() {
    alamat = TextEditingController();
    pesan = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    alamat.dispose();
    pesan.dispose();
    super.dispose();
  }
}
