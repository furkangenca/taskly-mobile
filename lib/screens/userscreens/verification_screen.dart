import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/constants/colors.dart';

import '../../controllers/users_controllers/signup_controller.dart';

class VerificationScreen extends StatelessWidget {
  final String verificationId;
  final String username;

  VerificationScreen({super.key, required this.verificationId, required this.username});

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
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
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
              onPressed: ()  {
                Get.find<SignupController>().verifyCode(
                    _codeController.text.trim(),
                    verificationId,
                    username,
                );
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
        backgroundColor: AppColors.orange,
        child: const Icon(Icons.arrow_back, color: AppColors.creamy,),
      ),
    );
  }
}
