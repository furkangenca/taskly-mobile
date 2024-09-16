import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTaskController extends GetxController {

  final titleController = TextEditingController();
  final detailsController = TextEditingController();
  var priority = 'Priority'.obs;
  var selectedDate = DateTime.now().obs;


  //********************************************************

  void addTask() {
    final String title = titleController.text;
    final String details = detailsController.text;

    final String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate.value);

    if (title.isNotEmpty && details.isNotEmpty && priority.value != 'Priority') {
      // Görev ekleme işlemi
      _saveTask(title, details, priority.value, formattedDate);

      // Inputları temizle
      titleController.clear();
      detailsController.clear();
      priority.value = 'Priority';
      selectedDate.value = DateTime.now();

      Get.back();
    } else {
      // Hata mesajı göster
      showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error', style: TextStyle(color: Colors.red[900], fontWeight: FontWeight.bold),),
            content: Text(
              priority.value == 'Priority'
                  ? 'Please select a priority for the task.'
                  : 'Please fill in all fields.',
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text('OK',style: TextStyle(color: Colors.teal,fontSize: 16),),
              ),
            ],
          );
        },
      );
    }
  }

//********************************************************

  Future<void> _saveTask(String title, String details, String priority, String date) async {
    try {
      // Firebase Auth üzerinden kullanıcı UID'sini al
      final String uid = FirebaseAuth.instance.currentUser!.uid;

      // Kullanıcıya özel "tasks" koleksiyonuna görev ekle
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid) // Kullanıcının UID'sine göre belge
          .collection('tasks') // Kullanıcıya özel "tasks" koleksiyonu
          .add({
        'title': title,
        'details': details,
        'priority': priority == 'Low' ? 1 : (priority == 'Medium' ? 2 : 3),
        'timestamp': FieldValue.serverTimestamp(),
        'date': date,
      });
    } catch (e) {
      print("Error saving task: $e");
    }
  }
//******************************************************


  void selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
    }
  }


}