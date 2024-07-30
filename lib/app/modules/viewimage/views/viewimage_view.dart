import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/viewimage_controller.dart';

class ViewimageView extends GetView<ViewimageController> {
  const ViewimageView({super.key});
  @override
  Widget build(BuildContext context) {
    final imageUrl = Get.arguments;
    final size = Get.size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bukti Transfer'),
        centerTitle: true,
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Image.network(
          imageUrl,
        ),
      ),
    );
  }
}
