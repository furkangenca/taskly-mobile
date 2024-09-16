import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/constants/colors.dart';
import 'package:to_do/controllers/users_controllers/login_controller.dart';
import 'package:to_do/screens/homescreen/homescreen.dart';
import 'package:to_do/screens/userscreens/loginscreen.dart';

import '../main.dart';

class LoadingScreen extends StatefulWidget {

  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  // Oturum açma durumunu kontrol eden bir fonksiyon
  Future<void> checkLoginStatus() async {
    final LoginController loginController = Get.find();

    bool isLoggedIn = loginController.checkIfLoggedIn();

    // Giriş durumuna göre yönlendirme
    await Future.delayed(const Duration(seconds: 2)); // 2 saniye bekleme
    if (isLoggedIn) {
      Get.offAll(() => const Main()); // Oturum açmışsa ana sayfayı göster
    } else {
      Get.offAll(() => const LoginScreen()); // Oturum açmamışsa giriş ekranını göster
    }
  }

  @override
  Widget build(BuildContext context) {
    // Yükleme ekranı görseli
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: AppColors.black,
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(color: AppColors.creamy,),
              SizedBox(height: 20),
              Text('Loading...',
                  style: TextStyle(
                      fontSize: 20,
                    fontFamily: 'lili',
                    color: AppColors.creamy,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
