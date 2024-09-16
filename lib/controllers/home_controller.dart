import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  var selectedDate = Rxn<DateTime>();
  var searchQuery = ''.obs;

  Stream<QuerySnapshot> get tasksStream {
    if (selectedDate.value == null) {
      return FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('tasks')
          .orderBy('priority', descending: true)
          .snapshots();
    } else {
      final formattedDate = DateFormat('yyyy-MM-dd').format(
          selectedDate.value!);
      return FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('tasks')
          .where('date', isEqualTo: formattedDate)
          .orderBy('priority', descending: true)
          .snapshots();
    }
  }

  void selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
    }
  }

  void clearDate() {
    selectedDate.value = null;
  }

  Future<void> markTaskAsCompleted(String taskId,
      Map<String, dynamic> task) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    // 'completedtasks' koleksiyonunu kullanıcı ID'si altında oluşturuyoruz
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('completedtasks')
        .doc(taskId)
        .set(task);

    // 'tasks' koleksiyonundan ilgili görevi siliyoruz
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .doc(taskId)
        .delete();
  }

  Future<void> deleteTask(String taskId) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    // Görevi 'tasks' koleksiyonundan siliyoruz
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .doc(taskId)
        .delete();
  }
}
