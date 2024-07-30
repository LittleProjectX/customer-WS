import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waroengsederhana/app/firebases/auth_service.dart';
import 'package:waroengsederhana/app/firebases/firestore_service.dart';
import 'package:waroengsederhana/app/models/all_food.dart';
import 'package:waroengsederhana/app/models/food.dart';
import 'package:waroengsederhana/app/routes/app_pages.dart';
import 'package:waroengsederhana/app/utils/loading.dart';
import 'package:waroengsederhana/colors.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({
    super.key,
  });

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  FirestoreService fireC = FirestoreService();
  AuthService authC = AuthService();
  bool isVisible = false;

  List<FoodModel> _filterMenu(String category, List<FoodModel> allMenu) {
    return allMenu
        .where((food) => food.category.split('.').last == category)
        .toList();
  }

  Widget getFoodInCategory(String title, category, List<FoodModel> allMenu) {
    List<FoodModel> categoryMenu = _filterMenu(category, allMenu);
    bool isVisible = false;

    if (categoryMenu.isNotEmpty) {
      isVisible = true;
    } else {
      isVisible = false;
    }

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
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                ),
                TextButton(
                    onPressed: () {
                      Get.toNamed(Routes.allfoodcategory, arguments: category);
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
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.detail,
                          arguments: categoryMenu[index].fId);
                    },
                    child: SizedBox(
                      height: 250,
                      width: 170,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 160,
                            width:160,
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
    final allFoodC = Get.put(Allfood());
    final uId = authC.auth.currentUser!.uid;

    return FutureBuilder(
      future: fireC.fetchData(uId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final listFood = snapshot.data!['food'];
          final listCart = snapshot.data!['cart'];
          allFoodC.deleteListFood();
          allFoodC.deleteListCart();

          // final foodMap = listFood!
          //     .map((doc) =>
          //         FoodModel.fromMap(doc.data() as Map<String, dynamic>))
          //     .toList();
          for (var doc in listFood!) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

            allFoodC.getAllMenu(
              doc.id,
              data['category'],
              data['name'],
              data['description'],
              data['imageUrl'],
              data['price'],
            );
          }

          for (var doc in listCart!) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            FoodModel food = FoodModel.fromMap(data);
            allFoodC.getAllCart(doc.id, food, data['qty']);
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'F O O D',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: tabColor, fontSize: 26),
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.cart);
                  },
                  child: Badge(
                    backgroundColor: tabColor,
                    label: Text(listCart.length.toString()),
                    child: const Icon(
                      Icons.shopping_cart,
                      size: 30,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  getFoodInCategory('Nasi + Lauk', 'lauk', allFoodC.listFood),
                  getFoodInCategory(
                      'Menu Lainnya', 'pelengkap', allFoodC.listFood),
                  getFoodInCategory('Minuman', 'minuman', allFoodC.listFood),
                  getFoodInCategory('Tambahan', 'tambahan', allFoodC.listFood),
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
