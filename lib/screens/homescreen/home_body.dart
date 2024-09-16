import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../constants/colors.dart';
import '../../controllers/home_controller.dart';

Widget buildBody({
  required DateTime? selectedDate,
  required String searchQuery,
  required Function(String) onSearchChanged,
  required Function(String taskId, Map<String, dynamic> task) markTaskAsCompleted,
  required Function(String taskId) deleteTask,
  required BuildContext context,
  required VoidCallback onSelectDate,
  required VoidCallback onClearDate,
}) {
  final HomeController controller = Get.find<HomeController>(); // HomeController'ı kullan

  return Padding(
    padding: const EdgeInsets.only(top: 100.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 0, 5),
                child: TextField(
                  onChanged: onSearchChanged,
                  decoration: InputDecoration(
                    hintText: 'Search tasks...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    fillColor: AppColors.creamy,
                    filled: true,

                  ),
                ),
              ),
            ),
            const SizedBox(width: 20,),
            GestureDetector(
              onTap: selectedDate != null ? onClearDate : onSelectDate, // Eğer tarih seçilmişse tıklanınca tarihi temizlesin, seçilmemişse tarih seçtirilsin
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.orange,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Text(
                    selectedDate != null
                        ? DateFormat('d MMMM yyyy').format(selectedDate)
                        : 'Select Date', // Eğer tarih seçilmişse tarihi göster, seçilmemişse 'Select Date' göster
                    style: const TextStyle(
                      color: AppColors.blacky,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 15,)

          ],
        ),

        const SizedBox(height: 20,),
        Expanded(
          child: Obx(() {
            return StreamBuilder<QuerySnapshot>(
              stream: controller.tasksStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final tasks = snapshot.data!.docs.where((doc) {
                  final title = doc['title'].toString().toLowerCase();
                  final details = doc['details'].toString().toLowerCase();
                  final query = searchQuery.toLowerCase();
                  return title.contains(query) || details.contains(query);
                }).toList();

                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index].data() as Map<String, dynamic>;
                    final taskId = tasks[index].id;
                    bool isCompleted = task['isCompleted'] ?? false;

                    final date = task['date'] ?? '';
                    final formattedDate = date.isNotEmpty
                        ? DateFormat('yyyy-MM-dd').format(DateTime.parse(date))
                        : 'No date';

                    return Dismissible(
                      key: Key(taskId),
                      direction: DismissDirection.horizontal,
                      onDismissed: (direction) {
                        if (direction == DismissDirection.endToStart) {
                          deleteTask(taskId);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.grey[900],
                              content: Text('${task['title']} silindi', style: const TextStyle(color: Colors.white)),
                            ),
                          );
                        } else if (direction == DismissDirection.startToEnd) {
                          if (!isCompleted) {
                            markTaskAsCompleted(taskId, task);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.grey[900],
                                content: Text('${task['title']} tamamlandı!', style: const TextStyle(color: Colors.white)),
                              ),
                            );
                          }

                        }
                      },
                      background: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.green,
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 9),
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: const Icon(Icons.check, color: Colors.white, size: 30,),
                      ),
                      secondaryBackground: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.red[900],
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 9),
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: const Icon(Icons.delete, color: Colors.white, size: 30,),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.creamy,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 9),
                        child: ListTile(
                          contentPadding: const EdgeInsets.fromLTRB(35, 0, 20, 0),
                          title: Text(task['title'] ?? '', style: const TextStyle(color: AppColors.blacky, fontSize: 16, fontWeight: FontWeight.bold)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(task['details'] ?? '', style: TextStyle(color: Colors.grey[800], fontSize: 13)),
                              Text(formattedDate, style: TextStyle(color: Colors.grey[500], fontStyle: FontStyle.italic, fontSize: 12)),
                            ],
                          ),
                          trailing: _buildPriorityIndicators(task['priority'] ?? 'Low'),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }),
        ),
      ],
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
