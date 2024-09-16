import 'package:flutter/material.dart';
import 'package:to_do/constants/colors.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'About us',
          style: TextStyle(color: AppColors.creamy), // AppBar başlığı rengi
        ),
        backgroundColor: Colors.transparent, // AppBar arka plan rengi
        iconTheme: const IconThemeData(color: AppColors.creamy), // Geri dönme ikonu rengi
        centerTitle: true, // Başlığı ortala
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: const Padding(
          padding:  EdgeInsets.fromLTRB(20, 100, 20, 20),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Divider(color: AppColors.creamy,),
              SizedBox(height: 10),
              Text(
                'This app helps you manage your tasks efficiently.',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.creamy,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
