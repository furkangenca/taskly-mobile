import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do/constants/colors.dart';

import '../../main.dart';

class VerifyPhoneScreen extends StatelessWidget {
  final String verificationId;

  VerifyPhoneScreen({Key? key, required this.verificationId}) : super(key: key);

  final TextEditingController _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          color: AppColors.black,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/verify.png',
              width: 200,
              height: 200,
            ),
            // Başlık
            const Text(
              'Enter Verification Code',
              style: TextStyle(
                fontSize: 24,
                color: AppColors.creamy,
                fontFamily: 'Lili',
              ),
            ),
            const SizedBox(height: 30),

            // Doğrulama Kodu Girişi
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _codeController,
                decoration: InputDecoration(
                  hintText: 'Verification Code',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  filled: true,
                  fillColor: AppColors.creamy,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Doğrulama Butonu
            ElevatedButton(
              onPressed: () async {
                final code = _codeController.text.trim();
                final credential = PhoneAuthProvider.credential(
                  verificationId: verificationId,
                  smsCode: code,
                );

                try {
                  UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

                  if (userCredential.user != null) {
                    // Başarıyla giriş yaptıktan sonra ana ekran veya uygun bir ekrana yönlendir
                    Get.offAll(() => const Main()); // Ya da uygun başka bir ekran
                  }
                } catch (e) {
                  Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 100),
              ),
              child: const Text(
                'Verify',
                style: TextStyle(
                  color: AppColors.creamy,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.back(); // Geri gitmek için kullanıyoruz
        },
        child: Icon(Icons.arrow_back, color: AppColors.creamy),
        backgroundColor: AppColors.orange,
      ),
    );
  }
}
