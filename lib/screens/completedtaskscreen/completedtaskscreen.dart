import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/completedtask_controller.dart';
import 'completed_task_body.dart';

class CompletedTask extends StatelessWidget {
  CompletedTask({super.key});

  final CompletedTaskController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: StreamBuilder<List<DocumentSnapshot>>(
          stream: _controller.completedTasksStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Bir hata oluştu: ${snapshot.error}'));
            }


            final completedTasks = snapshot.data!;

            return buildBody(
              deleteTask: _controller.deleteTask,
              markTaskAsActive: _controller.markTaskAsActive,
              completedTasks: completedTasks,
            );
          },
        ),
      ),
    );
  }
}
