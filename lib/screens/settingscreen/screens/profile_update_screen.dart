import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../scontrollers/user_controller.dart';
import 'package:to_do/constants/colors.dart';

class ProfileUpdateScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();

  ProfileUpdateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();

    usernameController.text = userController.username.value;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Update Profile',
          style: TextStyle(color: AppColors.creamy, fontWeight: FontWeight.bold, fontSize: 25),
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
            padding: const  EdgeInsets.fromLTRB(50, 100, 50, 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profil fotoğrafı seçme ve gösterme bölümü
                Obx(() {
                  return Stack(
                    children: [
                      CircleAvatar(
                        radius: 100,
                        backgroundImage: userController.profilePhotoUrl.value.isNotEmpty
                            ? NetworkImage(userController.profilePhotoUrl.value)
                            : const AssetImage('assets/images/default_avatar.png') as ImageProvider,
                        backgroundColor: Colors.grey[200],
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () async {
                            await userController.pickImage();
                            // Fotoğrafı seçtikten sonra otomatik olarak güncelle
                            await userController.uploadImageAndSaveURL();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.orange,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.camera_alt, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
                const SizedBox(height: 60),
                // Kullanıcı adı güncelleme kısmı
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Username',
                      style: TextStyle(color: AppColors.creamy, fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height:1),
                Container(
                  margin: const EdgeInsets.fromLTRB(50, 0, 50, 0),
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
                    controller: usernameController,
                    maxLength: 10, // Karakter sınırı (15 karakter örnek olarak)
                    decoration: InputDecoration(
                        counterText: '', // Karakter sayacını gizlemek için
                        border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      prefixIcon: const Icon(Icons.person, color: AppColors.blacky,)
                    ),
                    style: const TextStyle(color: AppColors.blacky),
                  ),
                ),
                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () async {
                    await userController.updateProfile(usernameController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                    elevation: 5,
                  ),
                  child: const Text(
                    'Update Username',
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                const SizedBox(height: 80,),
                ElevatedButton(
                  onPressed: ()  {
                    userController.deleteAccount(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                    elevation: 5,
                  ),
                  child: const Text(
                    'Delete Account',
                    style: TextStyle(color: Colors.white),
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
