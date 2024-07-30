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

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  FirestoreService fireC = FirestoreService();
  AuthService authC = AuthService();
  final cartListC = Get.put(Allfood());
  String? selectedItem;
  List<String> itemDrop = [
    'JEMPUT DI WARUNG',
    'Sadabuan',
    'Losung Batu',
    'Untemanis',
    'Sitataring',
    'Kampung Tobat',
    'Kampung Tobu',
    'Kampung Baru',
    'Samora',
    'Kampung Losung',
    'Padang Matinggi',
    'Sitamiang',
    'Batunadua',
    'Palopat',
  ];

  @override
  Widget build(BuildContext context) {
    final size = Get.size;
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: fireC.getOnlyCart(authC.auth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          cartListC.listCart.clear();
          final snap = snapshot.data!.docs;
          for (var doc in snap) {
            Map<String, dynamic> food = doc['food'] as Map<String, dynamic>;
            FoodModel myFood = FoodModel.fromMap(food);
            cartListC.listCart
                .add(CartItem(cId: doc.id, food: myFood, qty: doc['qty']));
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'C A R T',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: tabColor, fontSize: 26),
              ),
              actions: [
                cartListC.listCart.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          Get.defaultDialog(
                              title: 'Perhatian',
                              content: const Text(
                                  'Apahah anda yakin untuk menghapus seluruh cart?'),
                              textCancel: 'Batal',
                              textConfirm: 'Ya',
                              onCancel: () => Get.back(),
                              onConfirm: () {
                                fireC.deleteAllCarts(
                                    authC.auth.currentUser!.uid);
                                Get.back();
                              });
                        },
                        icon: const Icon(Icons.delete))
                    : Container()
              ],
            ),
            body: cartListC.listCart.isEmpty
                ? const Center(
                    child: Text(
                      'Tidak ada data',
                      style: TextStyle(fontSize: 24),
                    ),
                  )
                : Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: ListView.builder(
                          itemCount: cartListC.listCart.length,
                          itemBuilder: (context, index) {
                            final String price = cartListC
                                .listCart[index].food.price
                                .toStringAsFixed(0);

                            return Container(
                                width: size.width,
                                margin: const EdgeInsets.only(bottom: 10),
                                padding: const EdgeInsets.all(10),
                                color: whiteColor,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      height: 100,
                                      child: Image.network(cartListC
                                          .listCart[index].food.imageUrl),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            cartListC.listCart[index].food.name,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            cartListC.listCart[index].food
                                                .description,
                                            maxLines: 2,
                                            overflow: TextOverflow.clip,
                                            style: const TextStyle(
                                                overflow: TextOverflow.clip),
                                          ),
                                          Text(
                                            'Rp $price',
                                            style:
                                                TextStyle(color: greyColor400),
                                          ),
                                          Row(
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    if (cartListC
                                                            .listCart[index]
                                                            .qty >
                                                        1) {
                                                      fireC.minQty(
                                                          authC.auth
                                                              .currentUser!.uid,
                                                          cartListC
                                                              .listCart[index]
                                                              .cId,
                                                          cartListC
                                                              .listCart[index]
                                                              .qty);
                                                    } else {
                                                      fireC.deleteCart(
                                                          authC.auth
                                                              .currentUser!.uid,
                                                          cartListC
                                                              .listCart[index]
                                                              .cId);
                                                    }
                                                  },
                                                  icon:
                                                      const Icon(Icons.remove)),
                                              Text(
                                                cartListC.listCart[index].qty
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: tabColor),
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    fireC.plusQty(
                                                        authC.auth.currentUser!
                                                            .uid,
                                                        cartListC
                                                            .listCart[index]
                                                            .cId,
                                                        cartListC
                                                            .listCart[index]
                                                            .qty);
                                                  },
                                                  icon: const Icon(Icons.add)),
                                              const Spacer(),
                                              IconButton(
                                                  onPressed: () {
                                                    Get.defaultDialog(
                                                        title: 'Perhatian',
                                                        content: const Text(
                                                            'Apahah anda yakin untuk menghapus cart ini?'),
                                                        textCancel: 'Batal',
                                                        textConfirm: 'Ya',
                                                        onCancel: () =>
                                                            Get.back(),
                                                        onConfirm: () {
                                                          fireC.deleteCart(
                                                              authC
                                                                  .auth
                                                                  .currentUser!
                                                                  .uid,
                                                              cartListC
                                                                  .listCart[
                                                                      index]
                                                                  .cId);
                                                          Get.back();
                                                        });
                                                  },
                                                  icon:
                                                      const Icon(Icons.delete))
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ));
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                          height: size.height * 1 / 5,
                          width: size.width,
                          color: whiteColor,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Pilih Lokasi Anda :',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: DropdownButton(
                                  hint: const Text(
                                    'Pilih Lokasi',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  value: selectedItem,
                                  items: itemDrop.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedItem = newValue;
                                      cartListC.getOngkir(newValue.toString());
                                    });
                                  },
                                ),
                              ),
                              const Spacer(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('SubTotal'),
                                            Text(
                                                'Rp ${cartListC.getSubTotal().toStringAsFixed(0)}'),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('Ongkir'),
                                            Obx(() => Text(
                                                'Rp ${cartListC.ongkir.toString()}')),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'Total',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              'Rp ${cartListC.totalPrice().toStringAsFixed(0)}',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (selectedItem != null) {
                                        Get.toNamed(Routes.checkout);
                                      } else {
                                        Get.snackbar('Perhatian',
                                            'Mohon untuk memilih pengiriman');
                                      }
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      width: size.width * 0.5,
                                      height: size.height * 1 / 12,
                                      color: tabColor,
                                      child: const Center(
                                        child: Text(
                                          'CHECKOUT',
                                          style: TextStyle(
                                              color: whiteColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
          );
        }
        return const LoadingView();
      },
    );
  }
}
