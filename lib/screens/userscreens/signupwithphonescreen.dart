import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:to_do/constants/colors.dart';
import 'package:to_do/controllers/users_controllers/signup_controller.dart';
import 'package:get/get.dart';

class SignupWithPhoneScreen extends StatelessWidget {
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
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // Geri Dön Butonu
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: AppColors.creamy),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
              Image.asset(
                'assets/images/signup.png',
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 10),

              const Center(
                child: Text(
                  'Sign up with your phone number',
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColors.creamy,
                    fontFamily: 'Lili',
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Kullanıcı Adı Girişi
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: TextField(
                  onChanged: (value) => _controller.username.value = value,
                  maxLength: 10, // Karakter sınırı (15 karakter örnek olarak)
                  decoration: const InputDecoration(
                    counterText: '', // Karakter sayacını gizlemek için
                    hintText: 'Username',
                    hintStyle: TextStyle(
                      color: Colors.grey, // Gri yazı
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
              const SizedBox(height: 25),

              // Telefon Numarası Girişi
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
                      color: Colors.grey, // Gri yazı
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

              // Telefon formatı bilgisi
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

              const SizedBox(height: 40),

              // Kayıt Ol Butonu
              ElevatedButton(
                onPressed: () {
                  _controller.signUpWithPhone();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: AppColors.orange,
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 100,
                  ),
                ),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    color: AppColors.creamy,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
