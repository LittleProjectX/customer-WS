import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:waroengsederhana/app/modules/landing/widgets/landing_button.dart';
import 'package:waroengsederhana/app/routes/app_pages.dart';
import 'package:waroengsederhana/colors.dart';
import '../controllers/landing_controller.dart';

class LandingView extends GetView<LandingController> {
  const LandingView({super.key});
  @override
  Widget build(BuildContext context) {
    final size = Get.size;
    return Scaffold(
        backgroundColor: tabColor,
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 60,
              ),
              const Text(
                'Selamat datang di',
                style: TextStyle(fontSize: 22, color: textColor),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: size.width * 0.75,
                child: Image.asset(
                  'assets/images/waroeng.png',
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              const CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage('assets/images/cat.jpeg'),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'FAHRI RAMADHAN',
                style: TextStyle(
                    fontSize: 22,
                    color: textColor,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Jl. Merdeka, Losung Batu, Kec. Padangsidimpuan Utara, Kota Padang Sidempuan',
                textAlign: TextAlign.center,
                style: TextStyle(color: textColor),
              ),
              const Spacer(),
              Container(
                  height: 50,
                  width: size.width * 0.7,
                  margin: const EdgeInsets.only(bottom: 20),
                  child: LandingButton(
                    ontap: () => Get.toNamed(Routes.login),
                  ))
            ],
          ),
        ));
  }
}
