import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../constants/colors.dart';

Widget buildBody({
  required Function(String) deleteTask,
  required Function(String, Map<String, dynamic>) markTaskAsActive,
  required List<DocumentSnapshot> completedTasks,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 100),
    child: ListView.builder(
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
      itemCount: completedTasks.length,
      itemBuilder: (context, index) {
        final task = completedTasks[index].data() as Map<String, dynamic>;
        final taskId = completedTasks[index].id;

        return Dismissible(
          key: Key(taskId),
          direction: DismissDirection.horizontal,
          onDismissed: (direction) {
            if (direction == DismissDirection.endToStart) {
              deleteTask(taskId);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: AppColors.blacky,
                  content: Text('${task['title']} silindi', style: const TextStyle(color: Colors.white)),
                ),
              );
            } else if (direction == DismissDirection.startToEnd) {
              markTaskAsActive(taskId, task);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: AppColors.blacky,
                  content: Text('${task['title']} tamamlanmamış görevlere tekrar eklendi!', style: const TextStyle(color: Colors.white)),
                ),
              );
            }
          },
          background: Container(
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(100),
            ),
            margin: const EdgeInsets.symmetric(vertical: 9),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 20),
            child: const Icon(Icons.keyboard_return, color: Colors.white),
          ),
          secondaryBackground: Container(
            decoration: BoxDecoration(
              color: Colors.red[900],
              borderRadius: BorderRadius.circular(100),
            ),
            margin: const EdgeInsets.symmetric(vertical: 9),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.creamy,
              borderRadius: BorderRadius.circular(100),
            ),
            margin: const EdgeInsets.symmetric(vertical: 9),
            child: ListTile(
              contentPadding: const EdgeInsets.fromLTRB(35, 0, 20, 0),
              title: Text(
                task['title'] ?? '',
                style: const TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: AppColors.blacky,
                ),
              ),
              subtitle: Text(
                task['details'] ?? '',
                style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: Colors.grey[900],
                ),
              ),

              trailing: _buildPriorityIndicators(task['priority'] ?? 'Low'),

            ),
          ),
        );
      },
    ),
  );
}
Widget _buildPriorityIndicators(int priority) {
  List<Widget> circles = [];
  for (int i = 0; i < 3; i++) {
    circles.add(
      Icon(
        i < priority ? Icons.circle : Icons.circle_outlined,
        size: 16,
        color: AppColors.orange,
      ),
    );
    if (i < 2) {
      circles.add(const SizedBox(width: 1));
    }
  }
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: circles,
  );
}
