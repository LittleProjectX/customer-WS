import 'package:get/get.dart';

class FoodOrder extends GetxController {
  final String oId;
  final String uId;
  final String telp;
  final String order;
  final String alamatLengkap;
  final String imageUrl;
  final String pesan;
  final String status;

  FoodOrder({
    required this.oId,
    required this.uId,
    required this.telp,
    required this.order,
    required this.alamatLengkap,
    required this.imageUrl,
    required this.pesan,
    required this.status,
  });

  // factory FoodOrder.fromMap(Map<String, dynamic> map) {
  //   return FoodOrder(
  //       oId: map['oId'],
  //       uId: uId,
  //       telp: telp,
  //       order: order,
  //       alamatLengkap: alamatLengkap,
  //       imageUrl: imageUrl,
  //       pesan: pesan,
  //       status: status);
  // }
}
