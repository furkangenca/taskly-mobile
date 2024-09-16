import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CompletedTaskController extends GetxController {


  Stream<List<DocumentSnapshot>> get completedTasksStream {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('completedtasks')
        .snapshots()
        .map((snapshot) => snapshot.docs);
  }

  Future<void> markTaskAsActive(String taskId, Map<String, dynamic> task) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('users')
        .doc(userId)
        .collection('tasks')
        .doc(taskId)
        .set(task);
    await FirebaseFirestore.instance.collection('users')
        .doc(userId)
        .collection('completedtasks')
        .doc(taskId)
        .delete();
  }

  Future<void> deleteTask(String taskId) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('users')
        .doc(userId)
        .collection('completedtasks')
        .doc(taskId)
        .delete();
  }
}
