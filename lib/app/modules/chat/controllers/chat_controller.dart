import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  late TextEditingController msg;

  @override
  void onInit() {
    msg = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    msg.dispose();
    super.dispose();
  }
}
