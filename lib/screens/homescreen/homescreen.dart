import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/controllers/home_controller.dart';
import '../../constants/colors.dart';
import 'home_body.dart';
import '../addtaskscreen/addtaskscreen.dart';

class Home extends StatelessWidget {

  Home({super.key});

  final HomeController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: Container(
              decoration: const BoxDecoration(
              image: DecorationImage(
              image: AssetImage('assets/images/background.jpg'),
              fit: BoxFit.cover,
              ),
              ),
              child: Obx(() => buildBody(
                selectedDate: _controller.selectedDate.value,
                markTaskAsCompleted: _controller.markTaskAsCompleted,
                deleteTask: _controller.deleteTask,
                searchQuery: _controller.searchQuery.value,
                onSearchChanged: (query) {
                  _controller.searchQuery.value = query;
                },
                context: context,
                onSelectDate: () => _controller.selectDate(context),
                onClearDate: _controller.clearDate,
      ))),


      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTask()),
          );
        },
        backgroundColor: AppColors.orange,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 3, color: AppColors.orange),
          borderRadius: BorderRadius.circular(100),
        ),
        child: const Icon(Icons.add, size: 35, color: AppColors.creamy),
      ),
    );
  }
}
