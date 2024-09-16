import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/screens/settingscreen/screens/profile_update_screen.dart';
import '../scontrollers/user_controller.dart';
import 'package:to_do/constants/colors.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final userController = Get.find<UserController>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(color: AppColors.creamy,  fontSize: 27),
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
                // Profil fotoğrafı
                Obx(() {
                  return Container(
                    padding: const EdgeInsets.all(4), // Kenar boşluğunu artırarak kenarlığı belirginleştirin
                    decoration: BoxDecoration(
                      color: AppColors.blacky, // Kenar rengini ayarlayın
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 100,
                      backgroundImage: userController.profilePhotoUrl.value.isNotEmpty
                          ? NetworkImage(userController.profilePhotoUrl.value)
                          : const AssetImage('assets/images/default_avatar.png') as ImageProvider,
                      backgroundColor: Colors.grey[200],
                    ),
                  );
                }),
                const SizedBox(height: 50),

                // Kullanıcı adı
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: Colors.black45.withOpacity(0.4),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.person, color: AppColors.creamy,),
                        const SizedBox(width: 20,),
                        Text(
                          userController.username.value,
                          style: const TextStyle(
                            fontSize: 19,
                            color: AppColors.creamy,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: Colors.black45.withOpacity(0.4),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.mail, color: AppColors.creamy,),
                        const SizedBox(width: 20),
                        Obx(() {
                          final email = userController.email.value;
                          final phoneNumber = userController.phoneNumber.value;

                          return Text(
                            email.isNotEmpty ? email : (phoneNumber.isNotEmpty ? phoneNumber : 'No contact info available'),
                            style: const TextStyle(
                              fontSize: 17,
                              color: AppColors.creamy,
                            ),
                          );
                        }),
                      ],
                    ),
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
