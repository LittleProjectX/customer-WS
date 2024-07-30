import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:waroengsederhana/app/firebases/auth_service.dart';
import 'package:waroengsederhana/app/firebases/firestore_service.dart';
import 'package:waroengsederhana/app/models/all_food.dart';
import 'package:waroengsederhana/app/models/cart_item.dart';
import 'package:waroengsederhana/app/models/food.dart';
import 'package:waroengsederhana/app/routes/app_pages.dart';
import 'package:waroengsederhana/app/utils/loading.dart';
import 'package:waroengsederhana/colors.dart';

import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  const DetailView({super.key});
  @override
  Widget build(BuildContext context) {
    FirestoreService fireC = FirestoreService();
    final fId = Get.arguments;
    AuthService authC = AuthService();
    final cartC = Get.put(Allfood());
    final size = Get.size;

    return FutureBuilder<DocumentSnapshot<Object?>>(
      future: fireC.getById(fId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final data = snapshot.data!.data();
          Map<String, dynamic> food = data as Map<String, dynamic>;
          FoodModel currentFood = FoodModel(
              fId: fId,
              category: food['category'],
              name: food['name'],
              description: food['description'],
              price: food['price'],
              imageUrl: food['imageUrl']);
          // print('ini adalah food ${currentFood.name}');

          return Scaffold(
              appBar: AppBar(
                title: Text(
                  food['name'],
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: tabColor,
                      fontSize: 26),
                ),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.5,
                    width: size.width,
                    child: Image.network(
                      food['imageUrl'],
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          food['name'],
                          style: const TextStyle(
                              fontSize: 34, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          food['description'],
                          style: const TextStyle(fontSize: 18),
                        ),
                        Text(
                          'Rp ${food['price']}',
                          style: TextStyle(fontSize: 20, color: greyColor400),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
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
                              CartItem? myCart =
                                  cartC.listCart.firstWhereOrNull((item) {
                                bool isSame = item.food.fId == fId;
                                return isSame;
                              });

                              if (myCart != null) {
                                fireC.plusQty(authC.auth.currentUser!.uid,
                                    myCart.cId, myCart.qty);
                                Get.snackbar('Pemberitahuan',
                                    'Menu sudah ada, berhasil menambah jumlah');
                                Get.offAllNamed(Routes.home);
                              } else {
                                fireC.addCart(
                                    authC.auth.currentUser!.uid, currentFood);
                                Get.offAllNamed(Routes.home);
                                Get.snackbar(
                                    'Pemberitahuan', 'Berhasil menambahkan');
                              }
                            },
                            child: const Text(
                              'TAMBAH KE CART',
                              style: TextStyle(
                                color: whiteColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ))),
                  ),
                ],
              ));
        }
        return const LoadingView();
      },
    );
  }
}
