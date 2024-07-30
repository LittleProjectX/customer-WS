import 'package:waroengsederhana/app/models/food.dart';

class CartItem {
  final String cId;
  final FoodModel food;
  final int qty;

  CartItem({
    required this.cId,
    required this.food,
    required this.qty,
  });

  Map<String, dynamic> toJson() {
    return {
      'food': food,
      'qty': qty,
    };
  }
}
