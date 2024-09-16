import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/constants/colors.dart';

import '../scontrollers/user_controller.dart';

class ChangePasswordScreen extends StatelessWidget {

  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        title: const Text(
          'Change Password',
          style: TextStyle(color: AppColors.creamy),
        ),
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: AppColors.creamy),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(60.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // İçeriği ortala
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.creamy,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: oldPasswordController,
                    decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.lock, color: AppColors.blacky,),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      hintText: 'Old Password', // Placeholder metin
                      hintStyle: TextStyle(color: Colors.grey[600], fontSize: 14), // Placeholder metin rengi
                      floatingLabelBehavior: FloatingLabelBehavior.auto, // Label'ın yerini ayarlar
                    ),
                    style: const TextStyle(color: AppColors.blacky),
                    obscureText: true, // Şifrelerin gizli gösterilmesi
                  ),
                ),

                const SizedBox(height: 30),

                Container(
                  decoration: BoxDecoration(
                    color: AppColors.creamy,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: newPasswordController,
                    decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.lock, color: AppColors.blacky,),
                        border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,

                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      hintText: 'New Password', // Placeholder metin
                      hintStyle: TextStyle(color: Colors.grey[600], fontSize: 14), // Placeholder metin rengi
                      floatingLabelBehavior: FloatingLabelBehavior.auto, // Label'ın yerini ayarlar
                    ),
                    style: const TextStyle(color: AppColors.blacky),
                    obscureText: true, // Şifrelerin gizli gösterilmesi
                  ),
                ),

                const SizedBox(height: 30),

                ElevatedButton(
                  onPressed: () async {
                    await userController.changePassword(
                      oldPasswordController.text,
                      newPasswordController.text,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // Daha sivri köşeler
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    elevation: 5,
                  ),
                  child: const Text(
                    'Change Password',
                    style: TextStyle(color: AppColors.creamy),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
