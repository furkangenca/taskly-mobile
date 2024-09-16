// app_bar_content.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';
import 'main_controller.dart';

class AppBarContent extends StatelessWidget implements PreferredSizeWidget {
  const AppBarContent({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    final MainController controller = Get.find();

    return Obx(() {
      return AppBar(
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            controller.selectedIndex.value == 0
                ? Image.asset('assets/images/home.png', width: 60, height: 60,)
                : controller.selectedIndex.value == 1
                ? const Icon(
              Icons.check,
              size: 35,
              color: AppColors.creamy,
            )
                : controller.selectedIndex.value == 2
                ? const Icon(
              Icons.settings,
              size: 35,
              color: AppColors.creamy,
            )
                : const SizedBox.shrink(),
            const SizedBox(width: 1),
            Text(
              controller.selectedIndex.value == 0
                  ? 'Taskly'
                  : controller.selectedIndex.value == 1
                  ? 'Completed Tasks'
                  : 'Settings',
              style: const TextStyle(
                fontSize: 25,
                color: AppColors.creamy,
                fontFamily: 'Protest',
                letterSpacing: 5,
              ),
            ),
          ],
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            size: 35,
            color: AppColors.creamy,
          ),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      );
    });
  }
}
