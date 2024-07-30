import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waroengsederhana/app/firebases/firestore_service.dart';
import 'package:waroengsederhana/app/models/food.dart';
import 'package:waroengsederhana/app/utils/loading.dart';
import 'package:waroengsederhana/colors.dart';

class AllfoodcategoryView extends StatefulWidget {
  const AllfoodcategoryView({super.key});

  @override
  State<AllfoodcategoryView> createState() => _AllfoodcategoryViewState();
}

class _AllfoodcategoryViewState extends State<AllfoodcategoryView> {
  final String category = Get.arguments;

  List<FoodModel> _filterMenu(String category, List<FoodModel> allMenu) {
    return allMenu
        .where((food) => food.category.split('.').last == category)
        .toList();
  }

  Widget getFoodInCategory(String category, List<FoodModel> allMenu) {
    List<FoodModel> categoryMenu = _filterMenu(category, allMenu);
    bool isVisible = false;

    return Visibility(
      visible: isVisible,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: 280,
        color: whiteColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {
                      // Get.toNamed(Routes.allfoodcategory, arguments: category);
                    },
                    child: const Text(
                      'Lihat semua >>',
                      style: TextStyle(color: tabColor),
                    ))
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: categoryMenu.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 250,
                    width: 170,
                    // color: greyColor400,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 160,
                          padding: const EdgeInsets.all(5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.network(
                              categoryMenu[index].imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Text(
                          categoryMenu[index].name,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.visible),
                        ),
                        Text(
                          'Rp ${categoryMenu[index].price.toStringAsFixed(0)}',
                          style: TextStyle(color: greyColor400),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    FirestoreService fireC = FirestoreService();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CATEGORY',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: tabColor, fontSize: 26),
        ),
      ),
      body: FutureBuilder<QuerySnapshot<Object?>>(
        future: fireC.getOnlyMenu(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final allFood = snapshot.data!.docs;
            List<FoodModel> listFood = allFood.map((doc) {
              return FoodModel.fromMap(doc.data() as Map<String, dynamic>);
            }).toList();
            List<FoodModel> getCategory = _filterMenu(category, listFood);
            return GridView.builder(
              itemCount: getCategory.length,
              padding: const EdgeInsets.all(15),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.7,
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              itemBuilder: (context, index) {
                return Container(
                  color: whiteColor,
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Container(
                              child: getCategory[index].imageUrl != ''
                                  ? Image.network(
                                      getCategory[index].imageUrl,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      'assets/images/no_image.jpg',
                                      fit: BoxFit.cover,
                                    ))),
                      Text(
                        getCategory[index].name,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Rp ${getCategory[index].price.toStringAsFixed(0)}',
                        style: TextStyle(color: greyColor400),
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return const LoadingView();
        },
      ),
    );
  }
}
