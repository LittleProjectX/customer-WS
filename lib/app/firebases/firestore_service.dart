import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:waroengsederhana/app/models/food.dart';
import 'package:waroengsederhana/app/models/user.dart';

class FirestoreService extends GetxController {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference food = FirebaseFirestore.instance.collection('food');
  CollectionReference cart = FirebaseFirestore.instance.collection('cart');
  CollectionReference order = FirebaseFirestore.instance.collection('order');
  CollectionReference owner = FirebaseFirestore.instance.collection('owner');
  CollectionReference cards = FirebaseFirestore.instance.collection('cards');

  Future<void> addUser(String uId, name, phone, profilPict) async {
    try {
      var user = UserModel(
        uId: uId,
        name: name,
        phone: phone,
        profilPict: profilPict,
        isOnline: false,
      );
      await users.doc(uId).set(user.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addFood(
      String category, name, description, imageUrl, double price) async {
    try {
      await food.add({
        'category': category,
        'name': name,
        'description': description,
        'price': price,
        'imageUrl': imageUrl,
      });
    } catch (e) {
      rethrow;
    }
  }

  void addOrder(
      String uId, telp, orders, alamatLengkap, imageUrl, pesan) async {
    try {
      await order.add({
        'uId': uId,
        'telp': telp,
        'order': orders,
        'alamatLengkap': alamatLengkap,
        'imageUrl': imageUrl,
        'pesan': pesan,
        'status': 'Orderan Baru',
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, List<DocumentSnapshot>>> fetchData(String uId) async {
    QuerySnapshot data1 = await food.get();
    QuerySnapshot data2 = await cart.doc(uId).collection('cartItem').get();

    return {
      'food': data1.docs,
      'cart': data2.docs,
    };
  }

  Future<QuerySnapshot<Object?>> getOnlyMenu() {
    return food.get();
  }

  Future<DocumentSnapshot<Object?>> getCards() {
    return cards.doc('GrGrArDa5Tbuc1UPxQ9m').get();
  }

  Future<QuerySnapshot<Object?>> getOwner() {
    return owner.get();
  }

  Stream<DocumentSnapshot<Object?>> getMyData(String uId) {
    return users.doc(uId).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getOnlyCart(String uId) {
    return cart.doc(uId).collection('cartItem').snapshots();
  }

  Future<QuerySnapshot<Object?>> getMyOrder(String uId) {
    return order.where('uId', isEqualTo: uId).get();
  }

  Future<DocumentSnapshot<Object?>> getById(String id) async {
    return await food.doc(id).get();
  }

  void addCart(String uId, FoodModel food) async {
    await cart.doc(uId).collection('cartItem').add({
      'food': food.toMap(),
      'qty': 1,
    });
  }

  Future<void> plusQty(String uId, String cId, int qty) {
    return cart
        .doc(uId)
        .collection('cartItem')
        .doc(cId)
        .update({'qty': qty + 1});
  }

  Future<void> minQty(String uId, String cId, int qty) {
    return cart
        .doc(uId)
        .collection('cartItem')
        .doc(cId)
        .update({'qty': qty - 1});
  }

  Future<void> editUser(String uId, name, phone, imageLink) {
    return users.doc(uId).update({
      'name': name,
      'phone': phone,
      'profilPict': imageLink,
    });
  }

  Future<void> deleteAllCarts(String uId) async {
    try {
      QuerySnapshot snapshot = await cart.doc(uId).collection('cartItem').get();

      for (QueryDocumentSnapshot doc in snapshot.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteCart(String uId, String cId) {
    return cart.doc(uId).collection('cartItem').doc(cId).delete();
  }
}
