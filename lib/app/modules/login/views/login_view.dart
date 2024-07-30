import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waroengsederhana/app/firebases/auth_service.dart';
import 'package:waroengsederhana/colors.dart';
import '../controllers/login_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final loginC = Get.put(LoginController());
  AuthService authC = AuthService();
  final _formKey = GlobalKey<FormState>();

  final bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = Get.size;
    return Scaffold(
      backgroundColor: tabColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: textColor),
        ),
        backgroundColor: tabColor,
        title: const Text('Verifikasi Telepon',
            style: TextStyle(color: textColor)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              const Text('Silahkan memasukkan nomor telepon',
                  style: TextStyle(fontSize: 18, color: textColor)),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: loginC.phone,
                  decoration: const InputDecoration(
                    labelText: 'Nomor Telepon',
                    hintText: 'Masukkan nomor telepon dengan kode negara 62',
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nomor telepon tidak boleh kosong';
                    } else if (!value.startsWith('62')) {
                      return 'Nomor telepon harus dimulai dengan 62, (contoh : 628xx xxx)';
                    }
                    return null;
                  },
                ),
              ),
              const Text('Nomor telepon harus dimulai dengan 62',
                  maxLines: 2,
                  style: TextStyle(color: blackColor, fontSize: 12)),
              const Text('(contoh : 628xx xxxx xxxx)',
                  maxLines: 2,
                  style: TextStyle(color: blackColor, fontSize: 12)),
              SizedBox(height: size.height * 0.5),
              _isLoading
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      height: 50,
                      width: size.width * 0.7,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5))),
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            authC.siginWithPhone(loginC.phone.text, context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Nomor telepon valid')),
                            );
                          }
                        },
                        child: const Text(
                          'VERIFIKASI',
                          style: TextStyle(
                              color: blackColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
