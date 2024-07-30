import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waroengsederhana/app/firebases/auth_service.dart';
import 'package:waroengsederhana/app/utils/loading.dart';
import 'package:waroengsederhana/colors.dart';
import 'package:waroengsederhana/firebase_options.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Misalnya, 'id' untuk Bahasa Indonesia
  FirebaseAuth.instance.setLanguageCode('id');
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.playIntegrity,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AuthService authC = AuthService();
    return StreamBuilder(
      stream: authC.streamAuthStatus,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                floatingActionButtonTheme: const FloatingActionButtonThemeData(
                    backgroundColor: tabColor),
                inputDecorationTheme: const InputDecorationTheme(
                    labelStyle: TextStyle(color: whiteColor),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: whiteColor)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: whiteColor))),
                scaffoldBackgroundColor: backgroundColor,
                textTheme: GoogleFonts.latoTextTheme()),
            title: "Application",
            initialRoute:
                snapshot.data != null && snapshot.data!.phoneNumber != null
                    ? Routes.home
                    : Routes.landing,
            getPages: AppPages.routes,
          );
        }
        return const LoadingView();
      },
    );
  }
}
