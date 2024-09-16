import 'package:flutter/material.dart';
import 'package:to_do/constants/colors.dart';
import 'package:to_do/controllers/users_controllers/signup_controller.dart';
import 'package:get/get.dart';
import 'package:to_do/screens/userscreens/signupwithphonescreen.dart';
import 'loginscreen.dart';


class SignupScreen extends StatelessWidget {

  final SignupController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          color: AppColors.black,
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                'assets/images/signup.png',
                width: 200,
                height: 200,
              ),
              const Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 30,
                  color: AppColors.creamy,
                  fontFamily: 'Protest',
                  letterSpacing: 3,
                ),
              ),
              const SizedBox(height: 20),

              // Username Input
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: TextField(
                  onChanged: (value) => _controller.username.value = value,
                  maxLength: 10, // Karakter sınırı (15 karakter örnek olarak)
                  decoration: const InputDecoration(
                    hintText: 'Username',
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
                    counterText: '', // Karakter sayacını gizlemek için
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // Email Input
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
                    suffixIcon: Icon(Icons.email, color: AppColors.blacky),
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // Password Input
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: TextField(
                  onChanged: (value) => _controller.password.value = value,
                  obscureText: true, // Şifreyi gizlemek için
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
                    suffixIcon: Icon(Icons.lock, color: AppColors.blacky),
                  ),
                ),
              ),

              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  _controller.signUpWithEmail(
                    _controller.email.value.trim(),
                    _controller.password.value.trim(),
                    _controller.username.value.trim(),
                  );
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
                  'Sign Up',
                  style: TextStyle(
                      color: AppColors.creamy, fontSize: 16),
                ),
              ),
              const SizedBox(height: 1),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(() => const LoginScreen());
                      },
                    child: const Text(
                      "Log In",
                      style: TextStyle(
                          color: AppColors.creamy,
                          fontWeight: FontWeight.bold),
                    ),
                  ),

                ],
              ),
              const SizedBox(height: 1),

              // Sign Up with Phone Number
              TextButton(
                onPressed: () {
                  Get.to(() => SignupWithPhoneScreen());
                },
                child: const Text(
                  'Sign Up with your phone number',
                  style: TextStyle(
                      color: AppColors.creamy,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
