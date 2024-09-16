import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/constants/colors.dart';
import 'package:to_do/screens/settingscreen/scontrollers/user_controller.dart';
import 'package:to_do/screens/settingscreen/screens/about_screen.dart';
import 'package:to_do/screens/settingscreen/screens/change_password_screen.dart';
import 'package:to_do/screens/settingscreen/screens/profile_screen.dart';
import 'package:to_do/screens/settingscreen/screens/profile_update_screen.dart';
import 'package:to_do/screens/userscreens/loginscreen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController controller = Get.find();

    // Kullanıcının şifre kullanarak mı yoksa telefonla mı giriş yaptığını kontrol et
    final user = controller.auth.currentUser;
    bool hasPasswordProvider = user?.providerData.any(
          (provider) => provider.providerId == 'password',
    ) ??
        false;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        padding: const EdgeInsets.only(top: 100),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Divider(color: AppColors.creamy),
            ListTile(
              leading: const Icon(Icons.person, color: AppColors.creamy),
              title: const Text(
                'Profile',
                style: TextStyle(color: AppColors.creamy),
              ),
              onTap: () {
                Get.to(() => ProfileScreen());
              },
            ),
            Divider(color: AppColors.creamy),
            ListTile(
              leading: const Icon(Icons.person_pin, color: AppColors.creamy),
              title: const Text(
                'Update Profile',
                style: TextStyle(color: AppColors.creamy),
              ),
              onTap: () {
                Get.to(() => ProfileUpdateScreen());
              },
            ),
            const Divider(color: AppColors.creamy),


            // Şifre kullanarak kaydolmuş kullanıcılar için şifre değiştirme alanını göster
            if (hasPasswordProvider) ...[
              ListTile(
                leading: const Icon(Icons.lock, color: AppColors.creamy),
                title: const Text(
                  'Change Password',
                  style: TextStyle(color: AppColors.creamy),
                ),
                onTap: () {
                  Get.to(() => ChangePasswordScreen());
                },
              ),
              const Divider(color: AppColors.creamy),
            ],

            ListTile(
              leading: const Icon(Icons.info, color: AppColors.creamy),
              title: const Text(
                'About Us',
                style: TextStyle(color: AppColors.creamy),
              ),
              onTap: () {
                Get.to(() => AboutScreen());
              },
            ),
            const Divider(color: AppColors.creamy),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red[800]),
              title: Text(
                'Log Out',
                style: TextStyle(
                    color: Colors.red[800],
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                controller.signOut();
                Get.offAll(() => const LoginScreen());
              },
            ),
            const Divider(color: AppColors.creamy),
          ],
        ),
      ),
    );
  }
}

