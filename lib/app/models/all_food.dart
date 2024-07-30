import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:waroengsederhana/app/models/cart_item.dart';
import 'package:waroengsederhana/app/models/food.dart';
import 'package:waroengsederhana/app/models/order.dart';

class Allfood extends GetxController {
  var ongkir = 0.obs;
  String alamat = '';

  final List<FoodModel> _listFood = [];
  List<FoodModel> get listFood => _listFood;

  final List<CartItem> _listCart = [];
  List<CartItem> get listCart => _listCart;

  final List<FoodOrder> _listOrder = [];
  List<FoodOrder> get listOrder => _listOrder;

  void deleteListFood() {
    _listFood.clear();
  }

  void deleteListCart() {
    _listCart.clear();
  }

  void deleteListOrder() {
    _listOrder.clear();
  }

  void getAllMenu(
      String fId, category, name, description, imageUrl, double price) {
    _listFood.add(FoodModel(
      fId: fId,
      category: category,
      name: name,
      description: description,
      price: price,
      imageUrl: imageUrl,
    ));
  }

  void getAllCart(String cId, FoodModel food, int qty) {
    _listCart.add(CartItem(
      cId: cId,
      food: food,
      qty: qty,
    ));
  }

  void getMyOrder(
      String oId, uId, telp, order, alamatLengkap, imageUrl, pesan, status) {
    _listOrder.add(FoodOrder(
        oId: oId,
        uId: uId,
        telp: telp,
        order: order,
        alamatLengkap: alamatLengkap,
        imageUrl: imageUrl,
        pesan: pesan,
        status: status));
  }

  void getOngkir(String newValue) {
    ongkir = 0.obs;
    alamat = newValue;
    if (newValue == 'Sadabuan' ||
        newValue == 'Losung Batu' ||
        newValue == 'Untemanis' ||
        newValue == 'Sitataring' ||
        newValue == 'Kampung Tobat' ||
        newValue == 'Kampung Tobu' ||
        newValue == 'Kampung Baru') {
      ongkir.value = 5000;
    } else if (newValue == 'Samora' ||
        newValue == 'Kampung Losung' ||
        newValue == 'Padang Matinggi' ||
        newValue == 'Sitamiang' ||
        newValue == 'Batunadua' ||
        newValue == 'Palopat') {
      ongkir.value = 10000;
    } else {
      ongkir.value = 0;
    }
  }

  double getSubTotal() {
    double subTotal = 0;
    for (CartItem cartItem in _listCart) {
      subTotal += cartItem.food.price * cartItem.qty;
    }
    return subTotal;
  }

  double totalPrice() {
    double total = getSubTotal() + ongkir.value;
    return total;
  }

// format type double menjadi bentuk harga
  String _formatPrice(double price) {
    return 'Rp ${price.toStringAsFixed(0)}';
  }

  String displayCartReceipt() {
    final receipt = StringBuffer();
    // string buffer berfungsi untuk memodifikasi banyak bentuk sekaligus menjadi bentuk string
    receipt.writeln('Here\'s your receipt');
    receipt.writeln();

    // format tanggal hari ini
    String myDate = DateFormat('yy-MM-dd HH:mm:ss').format(DateTime.now());

    receipt.writeln(myDate);
    receipt.writeln();
    receipt.writeln('------------------------');
    receipt.writeln();

    for (final cartItem in _listCart) {
      receipt.writeln(
          '${cartItem.qty} x ${cartItem.food.name} - ${_formatPrice(cartItem.food.price)}');
    }

    receipt.writeln('------------------------');
    receipt.writeln();
    receipt.writeln('Lokasi Pengiriman : $alamat');
    receipt.writeln('Sub Total : ${_formatPrice(getSubTotal())}');
    receipt.writeln('Ongkir : ${_formatPrice(ongkir.value.toDouble())} ');
    receipt.writeln('------------------------');
    receipt.writeln('Total : ${_formatPrice(totalPrice())}');

    return receipt.toString();
  }
}
