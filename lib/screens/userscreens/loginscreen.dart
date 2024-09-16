import 'package:flutter/material.dart';
import 'package:to_do/constants/colors.dart';
import 'package:to_do/controllers/users_controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:to_do/screens/userscreens/loginscreenwithphone.dart';
import 'package:to_do/screens/userscreens/signupscreen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final LoginController _controller = Get.find();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          color: AppColors.black,
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
                  Image.asset(
                    'assets/images/login.png',
                    width: 250,
                    height: 250,
                  ),
                  const Text(
                    'Taskly',
                    style: TextStyle(
                      fontSize: 30,
                      color: AppColors.creamy,
                      fontFamily: 'Protest',
                      letterSpacing: 5,
                    ),
                  ),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: TextField(
                  onChanged: (value) => _controller.email.value = value,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                    ),
                    filled: true,
                    fillColor: AppColors.creamy,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    suffixIcon: Icon(Icons.person, color: AppColors.blacky),
                  ),
                ),
              ),
              const SizedBox(height: 15),

              Padding(
                padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: TextField(
                  obscureText: true,
                  onChanged: (value) => _controller.password.value = value,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                    ),
                    filled: true,
                    fillColor: AppColors.creamy,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    suffixIcon: Icon(Icons.password, color: AppColors.blacky),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  _controller.signIn();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: AppColors.orange,
                  padding: const EdgeInsets.symmetric(
                      vertical: 12, horizontal: 100),
                ),
                child: const Text(
                  'Log In',
                  style: TextStyle(
                    color: AppColors.creamy,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(() => SignupScreen());
                    },
                    child: const Text(
                      "Create Now",
                      style: TextStyle(
                          color: AppColors.creamy,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 3),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Log In with",
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(() => LoginWithPhoneScreen());
                    },
                    child: const Text(
                      "Phone Number",
                      style: TextStyle(
                          color: AppColors.creamy,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
