import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waroengsederhana/app/firebases/auth_service.dart';
import 'package:waroengsederhana/app/firebases/firestore_service.dart';
import 'package:waroengsederhana/app/models/all_food.dart';
import 'package:waroengsederhana/app/routes/app_pages.dart';
import 'package:waroengsederhana/app/utils/loading.dart';
import 'package:waroengsederhana/colors.dart';

class AllOrders extends StatelessWidget {
  AllOrders({
    super.key,
  });
  final FirestoreService fireC = FirestoreService();
  final AuthService authC = AuthService();
  final listOrderC = Get.put(Allfood());
  final size = Get.size;

  Color _getOrderColor(String status) {
    switch (status) {
      case 'Orderan Baru':
        return Colors.red;
      case '`Diproses`':
        return Colors.blue;
      case 'Dikirim':
        return Colors.green;
      case 'selesai':
        return Colors.grey;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot<Object?>>(
      future: fireC.getMyOrder(authC.auth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final snap = snapshot.data!.docs;
          listOrderC.deleteListOrder();
          for (var doc in snap) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            listOrderC.getMyOrder(
              doc.id,
              data['uId'],
              data['telp'],
              data['order'],
              data['alamatLengkap'],
              data['imageUrl'],
              data['pesan'],
              data['status'],
            );
          }

          return Scaffold(
              appBar: AppBar(
                title: const Text(
                  'PESANAN',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: tabColor,
                    fontSize: 26,
                  ),
                ),
              ),
              body: snap.isNotEmpty
                  ? ListView.builder(
                      itemCount: listOrderC.listOrder.length,
                      itemBuilder: (context, index) {
                        final order = listOrderC.listOrder;
                        return Container(
                            width: size.width,
                            height: size.height,
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(color: whiteColor),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Spacer(),
                                    Container(
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:
                                            _getOrderColor(order[index].status),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      order[index].status,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'Telp : ',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Text(
                                      order[index].telp,
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Alamat : ',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Expanded(
                                      child: Text(
                                        order[index].alamatLengkap,
                                        maxLines: 5,
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Pesan : ',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Expanded(
                                      child: Text(
                                        order[index].pesan,
                                        maxLines: 5,
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: greyColor)),
                                    child: Text(order[index].order)),
                                const SizedBox(
                                  height: 20,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(Routes.viewimage,
                                        arguments: order[index].imageUrl);
                                  },
                                  child: SizedBox(
                                    height: 200,
                                    width: 150,
                                    child: Image.network(
                                      order[index].imageUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              ],
                            ));
                      },
                    )
                  : const Center(
                      child: Text(
                        'Tidak ada orderan saat ini',
                        style: TextStyle(fontSize: 24),
                      ),
                    ));
        }
        return const LoadingView();
      },
    );
  }
}