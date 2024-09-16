import 'package:flutter/material.dart';
import '../../controllers/addtask_controller.dart';
import 'addtask_appbar.dart';
import 'addtask_body.dart';
import 'package:get/get.dart';

class AddTask extends StatelessWidget {
  AddTask({super.key});

  final AddTaskController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,

      appBar: buildAppBar(context),

      body: Container(
          decoration: const BoxDecoration(
          image: DecorationImage(
          image: AssetImage('assets/images/background.jpg'),
          fit: BoxFit.cover,
          ),
          ),
          child: Obx(() => buildBody(
            context: context,
            titleController: _controller.titleController,
            detailsController: _controller.detailsController,
            priority: _controller.priority.value,
            selectedDate: _controller.selectedDate.value,
            selectDate: (context) => _controller.selectDate(context),
            addTask: _controller.addTask,
            onPriorityChanged: (String? newValue) {
              _controller.priority.value = newValue!;
                  },
              )),


    ));
  }
}
