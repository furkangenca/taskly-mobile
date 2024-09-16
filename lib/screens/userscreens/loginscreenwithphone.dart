
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:to_do/constants/colors.dart';
import 'package:to_do/controllers/users_controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:to_do/screens/userscreens/loginscreen.dart';

class LoginWithPhoneScreen extends StatelessWidget {
  final LoginController _controller = Get.find();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          color: AppColors.black,
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 40),
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
                      fontSize: 28,
                      color: AppColors.creamy,
                      fontFamily: 'Protest',
                      letterSpacing: 5,
                    ),
                  ),

              const SizedBox(height: 30),

              Padding(
                padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: IntlPhoneField(
                  initialCountryCode: 'TR',
                  onChanged: (phone) {
                    _controller.phoneNumber.value = phone.completeNumber;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Phone Number',
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
                    suffixIcon: Icon(Icons.phone, color: AppColors.blacky),
                  ),
                  dropdownIcon: const Icon(Icons.arrow_drop_down, color: AppColors.blacky),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '   5051234567',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),


              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: () {
                  _controller.verifyPhoneNumber(_controller.phoneNumber.value);

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
                    "Log In with email?",
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(() => const LoginScreen());
                    },
                    child: const Text(
                      "Back",
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
