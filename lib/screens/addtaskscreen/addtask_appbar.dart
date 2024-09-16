import 'package:flutter/material.dart';
import 'package:to_do/constants/colors.dart';


AppBar buildAppBar(BuildContext context) {


  return AppBar(
    backgroundColor: Colors.transparent,
    title: const Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 74, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(
            image: AssetImage('assets/images/addtask.png'),
            width: 55,
            height: 55,
          ),
          Text(
            'Add Task',
            style: TextStyle(
                fontSize: 25,
                letterSpacing: 2,
                color: AppColors.creamy,
                fontFamily: 'Protest'
            ),
          ),
        ],
      ),
    ),
    centerTitle: true,
    leading: IconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: Icon(Icons.arrow_back_ios, color: Colors.white),
    ),
  );
}