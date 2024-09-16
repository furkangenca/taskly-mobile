import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainController extends GetxController {
  var username = ''.obs;
  var profilePhotoUrl = ''.obs;
  var selectedIndex = 0.obs;

  void changePage(int index) {
    selectedIndex.value = index;
    Get.back();
  }

  //Drawer içerisinde öge yaratmak için parametre alan bir widget
  //Yani tekrar kullanılabilir bir widget

  Widget buildDrawerItem(IconData icon, String title, int index) {
    return ListTile(
      leading: Icon(icon, color: AppColors.creamy),
      title: Text(title, style: const TextStyle(color: AppColors.creamy)),
      onTap: () {
        changePage(index);
      },
    );
  }
}
