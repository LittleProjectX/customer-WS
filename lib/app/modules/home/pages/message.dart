import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waroengsederhana/app/firebases/firestore_service.dart';
import 'package:waroengsederhana/app/models/all_food.dart';
import 'package:waroengsederhana/app/models/user.dart';
import 'package:waroengsederhana/app/routes/app_pages.dart';
import 'package:waroengsederhana/app/utils/loading.dart';
import 'package:waroengsederhana/colors.dart';

class Message extends StatelessWidget {
  Message({
    super.key,
  });
  final FirestoreService fireC = FirestoreService();
  final listOrderC = Get.put(Allfood());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot<Object?>>(
      future: fireC.getOwner(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final snap = snapshot.data!.docs;

          List<UserModel> owner = snap.map((doc) {
            return UserModel.fromMap(doc.data() as Map<String, dynamic>);
          }).toList();

          return Scaffold(
              appBar: AppBar(
                title: const Text(
                  'CHAT',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: tabColor,
                    fontSize: 26,
                  ),
                ),
              ),
              body: listOrderC.listOrder.isNotEmpty
                  ? ListView.builder(
                      itemCount: snap.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => Get.toNamed(Routes.chat, arguments: {
                            'uId': owner[index].uId,
                            'name': owner[index].name,
                            'image': owner[index].profilPict
                          }),
                          child: Container(
                              margin: const EdgeInsets.only(top: 10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              color: whiteColor,
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage:
                                        NetworkImage(owner[index].profilPict),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    owner[index].name,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.message,
                                    color: Colors.green,
                                  )
                                ],
                              )),
                        );
                      },
                    )
                  : const Center(
                      child: Text('Tidak ada order saat ini'),
                    ));
        }
        return const LoadingView();
      },
    );
  }
}
