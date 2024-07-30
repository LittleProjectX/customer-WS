import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:waroengsederhana/colors.dart';

import '../controllers/about_controller.dart';

class AboutView extends GetView<AboutController> {
  const AboutView({super.key});
  @override
  Widget build(BuildContext context) {
    final size = Get.size;
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'TENTANG',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: tabColor, fontSize: 26),
          ),
        ),
        body: Column(
          children: [
            const Text(
              'Waroeng Sederhana',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: size.height * 0.4,
              width: size.width,
              child: Image.asset(
                'assets/images/foto.png',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Buka :',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Padding(
              padding: EdgeInsets.all(25),
              child: Text(
                'Setiap Hari : Pukul 07.00 - 18.00 WIB',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            const Spacer(),
            const Text(
              'Alamat :',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Padding(
              padding: EdgeInsets.all(25),
              child: Text(
                'Jl. Merdeka No.423, Losung Batu, Kec. Padangsidimpuan Utara, Kota Padang Sidempuan, Sumatera Utara 22711',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            )
          ],
        ));
  }
}
