import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waroengsederhana/app/modules/otp/views/otp_view.dart';
import 'package:waroengsederhana/app/routes/app_pages.dart';

class AuthService extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<User?> get streamAuthStatus => auth.authStateChanges();

  void siginWithPhone(String phoneNumber, BuildContext context) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: "+$phoneNumber",
          verificationCompleted: (credential) async {
            // await FirebaseAuth.instance.signInWithCredential(credential).then(
            //   (_) {
            //     Get.offAllNamed(Routes.userinfo);
            //   },
            // );
          },
          verificationFailed: (exception) {
            Get.snackbar('Perhatian', exception.message.toString());
          },
          codeSent: (verificationId, resendcode) async {
            String? smsCode = await Navigator.push(
              context,
              // Create the SelectionScreen in the next step.
              MaterialPageRoute(builder: (context) => OtpView()),
            );

            if (smsCode != null) {
              PhoneAuthCredential credential = PhoneAuthProvider.credential(
                  verificationId: verificationId, smsCode: smsCode);
              await FirebaseAuth.instance.signInWithCredential(credential).then(
                (value) {
                  Get.offAllNamed(Routes.userinfo);
                },
              );
            }
          },
          codeAutoRetrievalTimeout: (verificationid) {});
    } catch (e) {
      Get.snackbar('Perhatian', e.toString());
    }
  }

  Future<void> getOTP(String verificationId, String userOTP) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: userOTP,
      );
      await auth.signInWithCredential(credential);
      Get.offAllNamed(Routes.userinfo);
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message.toString());
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
    }
  }
}
