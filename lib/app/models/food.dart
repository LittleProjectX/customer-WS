import 'package:get/get.dart';

class FoodModel extends GetxController {
  final String fId;
  final String category;
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  FoodModel({
    required this.fId,
    required this.category,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'fId': fId,
      'category': category,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    };
  }

  factory FoodModel.fromMap(Map<String, dynamic> map) {
    return FoodModel(
      fId: map['fId'] ?? '',
      category: map['category'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: map['price'] ?? 0,
      imageUrl: map['imageUrl'] ?? '',
    );
  }
}

enum FoodCategory {
  lauk,
  pelengkap,
  minuman,
  tambahan,
}
