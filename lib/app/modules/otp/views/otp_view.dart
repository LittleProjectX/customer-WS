import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waroengsederhana/colors.dart';
import '../controllers/otp_controller.dart';

class OtpView extends GetView<OtpController> {
  const OtpView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final otpC = Get.put(OtpController());
    final size = Get.size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Konfirmasi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text('Masukkan kode verifikasi OTP',
                style: TextStyle(fontSize: 28)),
            const SizedBox(height: 10),
            Text('Kami telah mengirim kode verifikasi ke nomor anda'),
            const SizedBox(height: 20),
            SizedBox(
              height: 50,
              width: size.width * 0.5,
              child: TextField(
                autocorrect: false,
                autofocus: false,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 30, letterSpacing: 10),
                decoration: const InputDecoration(
                  hintText: '------',
                  hintStyle: TextStyle(color: blackColor, fontSize: 30),
                ),
                controller: otpC.otp,
                onChanged: (value) {
                  if (value.length == 6) {
                    Navigator.pop(context, value);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
