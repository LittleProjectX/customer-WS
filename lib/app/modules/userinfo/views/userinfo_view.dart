import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waroengsederhana/app/firebases/auth_service.dart';
import 'package:waroengsederhana/app/firebases/firestore_service.dart';
import 'package:waroengsederhana/app/modules/userinfo/controllers/userinfo_controller.dart';
import 'package:waroengsederhana/app/routes/app_pages.dart';
import 'package:waroengsederhana/colors.dart';

class UserinfoView extends StatefulWidget {
  const UserinfoView({super.key});

  @override
  State<UserinfoView> createState() => _UserinfoViewState();
}

class _UserinfoViewState extends State<UserinfoView> {
  String? imageLink = '';

  // memilih file dari memori
  Future<void> selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.isNotEmpty) {
      final imageLink =
          await Get.toNamed(Routes.addimage, arguments: result.files.first);
      if (imageLink != null) {
        setState(() {
          this.imageLink = imageLink;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final userC = Get.put(UserinfoController());
    FirestoreService fireC = FirestoreService();
    AuthService authC = AuthService();
    final size = Get.size;

    return Scaffold(
      backgroundColor: tabColor,
      appBar: AppBar(
        backgroundColor: tabColor,
        centerTitle: true,
        title: const Text(
          'USER PENGGUNA',
          style: TextStyle(color: textColor),
        ),
      ),
      body: Container(
        width: size.width,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 64,
                  backgroundImage: imageLink != null && imageLink!.isNotEmpty
                      ? NetworkImage(imageLink!)
                      : const AssetImage('assets/images/no_pict.jpeg')
                          as ImageProvider,
                ),
                Positioned(
                  bottom: 0,
                  left: 80,
                  child: Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: textColor),
                      child: IconButton(
                          onPressed: () {
                            selectFile();
                          },
                          icon: const Icon(Icons.add_a_photo))),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: size.width * 0.75,
              child: TextField(
                decoration: const InputDecoration(
                    label: Text('Nama Pengguna'),
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: textColor))),
                controller: userC.name,
              ),
            ),
            const Spacer(),
            SizedBox(
                height: 50,
                width: size.width * 0.7,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                    onPressed: () {
                      if (userC.name.text.isNotEmpty && imageLink != '') {
                        fireC.addUser(
                            authC.auth.currentUser!.uid.toString(),
                            userC.name.text,
                            authC.auth.currentUser!.phoneNumber.toString(),
                            imageLink.toString());
                        Get.offAllNamed(Routes.home);
                      } else {
                        Get.snackbar('Perhatian',
                            'Mohon untuk mengisi data dengan benar');
                      }
                    },
                    child: const Text(
                      'LANJUTKAN',
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ))),
          ],
        ),
      ),
    );
  }
}
