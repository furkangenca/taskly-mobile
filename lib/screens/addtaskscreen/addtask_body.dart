import 'package:flutter/material.dart';
import 'package:to_do/constants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import '../../controllers/addtask_controller.dart';


GestureDetector buildBody({
  required BuildContext context,
  required TextEditingController titleController,
  required TextEditingController detailsController,
  required String priority,
  required DateTime selectedDate,
  required void Function(BuildContext) selectDate,
  required void Function() addTask,
  required void Function(String?) onPriorityChanged,


}) {

  final AddTaskController _controller = Get.find();

  return GestureDetector(
    onTap: () {
      FocusScope.of(context).unfocus(); // Ekrana tıklanınca klavyeyi kapat
    },
    child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 100, 20, 0),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: AppColors.creamy,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Your Task Header',
                      labelStyle: TextStyle(
                        fontSize: 11,
                        color: Colors.black38,
                        fontWeight: FontWeight.bold,
                      ),
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  const Divider(color: Colors.black38, height: 1,),
                  TextField(
                    controller: detailsController,
                    decoration: const InputDecoration(
                      labelText: 'Write your notes...',
                      labelStyle: TextStyle(
                        fontSize: 12,
                        color: Colors.black38,
                        fontWeight: FontWeight.bold,
                      ),
                      border: InputBorder.none,
                    ),
                    maxLines: 7,
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const  [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ) ,
                  child: DropdownButton<String>(
                    value: priority,
                    onChanged: onPriorityChanged,
                    dropdownColor: Colors.grey[900],
                    underline: SizedBox(),
                    items: <String>['Low', 'Medium', 'High', 'Priority']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Container(
                          color: Colors.grey[900],
                          padding: EdgeInsets.symmetric(vertical: 1, horizontal: 7),
                          child: Text(value, style: TextStyle(color: Colors.white, fontSize: 15),),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0.5, 5, 0.5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.grey[900],
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.grey[900],
                        ),
                        padding: EdgeInsets.fromLTRB(12, 15, 0, 15),
                        child: Text(
                          selectedDate != null
                              ? DateFormat('yyyy-MM-dd').format(selectedDate)
                              : 'Select Date',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0.5, 0, 0.5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.grey[900],
                        ),
                        child: IconButton(
                          icon: Icon(Icons.calendar_month),
                          onPressed: () => selectDate(context),
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: addTask,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[900],
                    padding: EdgeInsets.fromLTRB(1, 1, 1, 1),
                  ),
                  child: Image.asset(
                    'assets/images/add.png',
                    height: 45,
                    width: 40,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
  );
}
