import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waroengsederhana/app/firebases/auth_service.dart';
import 'package:waroengsederhana/app/firebases/firestore_service.dart';
import 'package:waroengsederhana/app/models/food.dart';
// ignore: unused_import
import 'package:waroengsederhana/app/routes/app_pages.dart';
import 'package:waroengsederhana/app/utils/loading.dart';
import 'package:waroengsederhana/colors.dart';

class TambahanView extends StatelessWidget {
  TambahanView({super.key});
  final FirestoreService fireC = FirestoreService();
  final AuthService authC = AuthService();
  final List<FoodModel> allTambahan = [];
  final List<FoodModel> selectTambahan = [];

  List<FoodModel> _filterMenu(String category, List<FoodModel> allMenu) {
    return allMenu
        .where((food) => food.category.split('.').last == category)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final size = Get.size;
    return FutureBuilder(
      future: fireC.getOnlyMenu(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final snap = snapshot.data!.docs;
          for (var doc in snap) {
            allTambahan.add(FoodModel(
              fId: doc.id,
              category: doc['category'],
              name: doc['name'],
              description: doc['description'],
              price: doc['price'],
              imageUrl: doc['imageUrl'],
            ));
          }

          List<FoodModel> currentTambahan =
              _filterMenu('tambahan', allTambahan);

          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'TAMBAHAN',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: tabColor, fontSize: 26),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Stack(
                children: [
                  ListView.builder(
                    itemCount: currentTambahan.length,
                    itemBuilder: (context, index) {
                      allTambahan.clear();
                      selectTambahan.clear();
                      final String price =
                          currentTambahan[index].price.toStringAsFixed(0);
                      return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(10),
                          color: whiteColor,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 100,
                                height: 100,
                                child: Image.network(
                                    currentTambahan[index].imageUrl),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      currentTambahan[index].name,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      currentTambahan[index].description,
                                      maxLines: 2,
                                      style: const TextStyle(
                                          overflow: TextOverflow.clip),
                                    ),
                                    Text(
                                      'Rp $price',
                                      style: TextStyle(color: greyColor400),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      color: tabColor,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: const Icon(
                                    Icons.add,
                                    color: whiteColor,
                                  ),
                                ),
                              )
                            ],
                          ));
                    },
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
                            onPressed: () {},
                            child: const Text(
                              'SIMPAN',
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
        return const LoadingView();
      },
    );
  }
}
