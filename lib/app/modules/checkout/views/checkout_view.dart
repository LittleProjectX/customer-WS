import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waroengsederhana/app/firebases/auth_service.dart';
import 'package:waroengsederhana/app/firebases/firestore_service.dart';
import 'package:waroengsederhana/app/models/all_food.dart';
import 'package:waroengsederhana/app/modules/checkout/controllers/checkout_controller.dart';
import 'package:waroengsederhana/app/modules/checkout/widgets/pay_transfer.dart';
import 'package:waroengsederhana/app/routes/app_pages.dart';
import 'package:waroengsederhana/app/utils/loading.dart';
import 'package:waroengsederhana/colors.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  FirestoreService fireC = FirestoreService();
  AuthService authC = AuthService();
  final listCartC = Get.put(Allfood());
  final checkoutC = Get.put(CheckoutController());
  String? imageLink = '';

  // memilih file dari memori
  Future<void> selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.isNotEmpty) {
      final imageLink =
          await Get.toNamed(Routes.imagetranf, arguments: result.files.first);
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
    return FutureBuilder(
      future: fireC.getCards(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final snap = snapshot.data!.data();
          Map<String, dynamic> data = snap as Map<String, dynamic>;
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'CHECKOUT',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: tabColor,
                  fontSize: 26,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        TextField(
                          maxLines: 4,
                          keyboardType: TextInputType.multiline,
                          decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: blackColor)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: blackColor)),
                            label: Text(
                              'Alamat Lengkap',
                              style: TextStyle(color: blackColor),
                            ),
                          ),
                          controller: checkoutC.alamat,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          maxLines: 4,
                          keyboardType: TextInputType.multiline,
                          decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: blackColor)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: blackColor)),
                            label: Text(
                              'Pesan ke penjual',
                              style: TextStyle(color: blackColor),
                            ),
                          ),
                          controller: checkoutC.pesan,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'PILIH METODE PEMBAYARAN',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        PayTransfer(
                            bank: data['item1'],
                            number: data['number1'],
                            name: data['name1']),
                        const SizedBox(
                          height: 10,
                        ),
                        PayTransfer(
                            bank: data['item2'],
                            number: data['number2'],
                            name: data['name2']),
                        Container(
                          width: size.width,
                          height: 120,
                          decoration: BoxDecoration(
                              color: textfielColor,
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  selectFile();
                                },
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                    image: imageLink != null &&
                                            imageLink!.isNotEmpty
                                        ? NetworkImage(imageLink!)
                                        : const AssetImage(
                                                'assets/images/no_image.jpg')
                                            as ImageProvider,
                                  )),
                                ),
                              ),
                              const Text('Tambah Bukti Transfer')
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                        height: 50,
                        width: size.width * 0.7,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: tabColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                            onPressed: () {
                              if (checkoutC.alamat.text.isNotEmpty &&
                                  imageLink != null) {
                                fireC.addOrder(
                                  authC.auth.currentUser!.uid,
                                  authC.auth.currentUser!.phoneNumber,
                                  listCartC.displayCartReceipt(),
                                  checkoutC.alamat.text,
                                  imageLink.toString(),
                                  checkoutC.pesan.text,
                                );
                                fireC.deleteAllCarts(
                                    authC.auth.currentUser!.uid);
                                listCartC.listCart.clear();
                                Get.offAllNamed(Routes.order);
                              } else {
                                Get.snackbar('Perhatian',
                                    'Mohon untuk mengisi alamat dan bukti transfer');
                              }
                            },
                            child: const Text(
                              'BAYAR',
                              style: TextStyle(
                                color: whiteColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ))),
                  ),
                ],
              ),
            ),
          );
        }
        return LoadingView();
      },
    );
  }
}
