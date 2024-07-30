import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waroengsederhana/app/firebases/auth_service.dart';
import 'package:waroengsederhana/app/firebases/firestore_service.dart';
import 'package:waroengsederhana/app/modules/home/widget/profile_list_tile.dart';
import 'package:waroengsederhana/app/routes/app_pages.dart';
import 'package:waroengsederhana/app/utils/loading.dart';

class Profile extends StatefulWidget {
  const Profile({
    super.key,
  });

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  FirestoreService fireC = FirestoreService();
  AuthService authC = AuthService();
  // UserModel _filterUser(String uId, List<UserModel> allUser) {
  //   return allUser.where((user) => user.uId == uId);
  // }

  @override
  Widget build(BuildContext context) {
    final size = Get.size;
    return StreamBuilder<DocumentSnapshot<Object?>>(
      stream: fireC.getMyData(authC.auth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final snap = snapshot.data!.data();
          Map<String, dynamic> data = snap as Map<String, dynamic>;

          return Column(
            children: [
              SizedBox(
                height: size.height * 0.07,
              ),
              Column(
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(data['profilPict']),
                  ),
                  Text(
                    data['name'],
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    data['phone'],
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Column(
                children: [
                  ProfileListTile(
                    icon: Icons.person,
                    title: 'Ubah Profile',
                    subtitle: 'Mengubah nama, profil, dan data telepon',
                    onTap: () {
                      Get.toNamed(Routes.edituser);
                    },
                  ),
                  ProfileListTile(
                    icon: Icons.build,
                    title: 'Tentang',
                    subtitle: 'Tentang rumah makan',
                    onTap: () => Get.toNamed(Routes.about),
                  ),
                  // ProfileListTile(
                  //   icon: Icons.logout,
                  //   title: 'Keluar',
                  //   subtitle: 'Keluar dari akun',
                  //   onTap: () {
                  //     authC.signOut();
                  //   },
                  // )
                ],
              ),
              Container()
            ],
          );
        }
        return const LoadingView();
      },
    );
  }
}
