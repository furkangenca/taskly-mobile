import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/screens/settingscreen/scontrollers/user_controller.dart';
import '../constants/colors.dart';
import '../main/main_controller.dart';

Drawer buildDrawer() {
  final MainController controller = Get.find();
  final UserController userController = Get.find();

  return Drawer(
    child: Stack(
      children: [
        // Arka plan resmini ekleyin
        Positioned.fill(
          child: Container(
            decoration:const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'), // Arka plan resmi
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        // İçerik
        ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.black38,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(() {
                    final profilePhotoUrl = userController.profilePhotoUrl.value;
                    return CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      backgroundImage: profilePhotoUrl.isNotEmpty
                          ? NetworkImage(profilePhotoUrl)
                          : null,
                      child: profilePhotoUrl.isEmpty
                          ? const Icon(
                        Icons.person,
                        size: 40,
                        color: AppColors.creamy,
                      )
                          : null,
                    );
                  }),
                  const SizedBox(width: 20),
                  Obx(() => Text(
                    userController.username.value,
                    style: const TextStyle(
                      fontSize: 22,
                      color: AppColors.creamy,
                      fontFamily: 'lili',
                      letterSpacing: 1,
                    ),
                  )),
                ],
              ),
            ),
            controller.buildDrawerItem(Icons.task_rounded, 'Tasks', 0),
            const Divider(color: Colors.grey,),

            controller.buildDrawerItem(Icons.done_all, 'Completed Tasks', 1),
            const Divider(color: Colors.grey,),

            controller.buildDrawerItem(Icons.settings, 'Settings', 2),
            const Divider(color: Colors.grey,),

          ],
        ),
      ],
    ),
  );
}
