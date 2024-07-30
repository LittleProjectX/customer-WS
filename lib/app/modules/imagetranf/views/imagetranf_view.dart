import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waroengsederhana/app/firebases/auth_service.dart';
import 'package:waroengsederhana/colors.dart';

class ImagetranfView extends StatefulWidget {
  const ImagetranfView({super.key});

  @override
  State<ImagetranfView> createState() => _ImagetranfViewState();
}

class _ImagetranfViewState extends State<ImagetranfView> {
  final PlatformFile? pickedFile = Get.arguments;
  AuthService authC = AuthService();
  UploadTask? uploadTask;
  String? imageLink;
  bool snapStatus = false;

  // upload gambar
  Future<void> uploadFile(String uId) async {
    final path = 'buktiTransfer/$uId/${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    try {
      final ref = FirebaseStorage.instance.ref().child(path);
      setState(() {
        uploadTask = ref.putFile(file);
      });

      final snapshot = await uploadTask!.whenComplete(() {});
      imageLink = await snapshot.ref.getDownloadURL();

      setState(() {
        snapStatus = true;
      });

      Get.back(result: imageLink);
    } on FirebaseAuthException {
      setState(() {
        snapStatus = false;
      });
    } catch (e) {
      setState(() {
        snapStatus = false;
      });
    }
  }

  // loading saat mengupload gambar
  Widget buildProgress() {
    return StreamBuilder<TaskSnapshot>(
      stream: uploadTask?.snapshotEvents,
      builder: (BuildContext context, AsyncSnapshot<TaskSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final progress =
              snapshot.data!.bytesTransferred / snapshot.data!.totalBytes;
          final percentage = (progress * 100).toStringAsFixed(2);

          return Column(
            children: [
              LinearProgressIndicator(value: progress),
              const SizedBox(height: 8),
              Text('$percentage%'),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String uId = authC.auth.currentUser!.uid.toString();
    final size = Get.size;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 30),
              Container(
                height: size.height * 0.7,
                width: size.width,
                child: pickedFile != null
                    ? Image.file(File(pickedFile!.path!))
                    : Container(),
              ),
              buildProgress(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text(
                      'Batal',
                      style: TextStyle(color: blackColor, fontSize: 20),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      uploadFile(uId);
                    },
                    child: const Text(
                      'Ok',
                      style: TextStyle(color: blackColor, fontSize: 20),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
