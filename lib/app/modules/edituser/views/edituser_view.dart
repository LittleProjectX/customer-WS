import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waroengsederhana/app/firebases/auth_service.dart';
import 'package:waroengsederhana/app/firebases/firestore_service.dart';
import 'package:waroengsederhana/app/modules/edituser/controllers/edituser_controller.dart';
import 'package:waroengsederhana/app/routes/app_pages.dart';
import 'package:waroengsederhana/app/utils/loading.dart';
import 'package:waroengsederhana/colors.dart';

class EdituserView extends StatefulWidget {
  const EdituserView({super.key});

  @override
  State<EdituserView> createState() => _EdituserViewState();
}

class _EdituserViewState extends State<EdituserView> {
  FirestoreService fireC = FirestoreService();
  AuthService authC = AuthService();
  final editUserC = Get.put(EdituserController());
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
    final size = Get.size;
    return StreamBuilder(
      stream: fireC.getMyData(authC.auth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final snap = snapshot.data!.data();
          Map<String, dynamic> data = snap as Map<String, dynamic>;
          String myImage = data['profilPict'];
          editUserC.name.text = data['name'];
          editUserC.phone.text = data['phone'];

          return Scaffold(
            body: Container(
              width: size.width,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.07,
                  ),
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 64,
                        backgroundImage:
                            imageLink != null && imageLink!.isNotEmpty
                                ? NetworkImage(imageLink!)
                                : NetworkImage(myImage) as ImageProvider,
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
                          label: Text(
                            'Nama Pengguna',
                            style: TextStyle(color: blackColor),
                          ),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: blackColor))),
                      controller: editUserC.name,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: size.width * 0.75,
                    child: TextField(
                      decoration: const InputDecoration(
                          label: Text('No Telepon',
                              style: TextStyle(color: blackColor)),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: blackColor))),
                      controller: editUserC.phone,
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                      height: 50,
                      width: size.width * 0.7,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: tabColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5))),
                          onPressed: () {
                            fireC.editUser(
                                authC.auth.currentUser!.uid,
                                editUserC.name.text,
                                editUserC.phone.text,
                                imageLink!.isNotEmpty ? imageLink : myImage);
                            Get.snackbar('Perhatian', 'Berhasil mengubah data');
                            Get.offAllNamed(Routes.home);
                          },
                          child: const Text(
                            'SIMPAN',
                            style: TextStyle(
                              color: whiteColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ))),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      height: 40,
                      width: size.width * 0.4,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: whiteColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5))),
                          onPressed: () {
                            Get.offAllNamed(Routes.home);
                          },
                          child: const Text(
                            'BATAL',
                            style: TextStyle(
                              color: tabColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ))),
                ],
              ),
            ),
          );
        }
        return const LoadingView();
      },
    );
  }
}
