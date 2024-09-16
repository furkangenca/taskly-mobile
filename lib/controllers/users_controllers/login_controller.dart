import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../main.dart';
import '../../screens/userscreens/loginverify.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var phoneNumber = ''.obs;


  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signIn() async {
    // Yükleme diyalogunu aç
    Get.dialog(const Center(child: CircularProgressIndicator()), barrierDismissible: false);

    try {
      // E-posta ile giriş yapma
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );

      // Giriş başarılı ise anasayfaya yönlendir
      Get.offAll(() => const Main());
    } on FirebaseAuthException catch (e) {
      // Yükleme diyalogunu kapat
      Get.back();

      // Hata mesajlarını belirle
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = 'No user found for that email.';
          break;
        case 'wrong-password':
          message = 'Wrong password provided.';
          break;
        default:
          message = 'Something went wrong: ${e.message}';
      }
      // Hata mesajını göster
      Get.snackbar('Error', message, snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      // Yükleme diyalogunu kapat
      Get.back();

      // Diğer hataları göster
      Get.snackbar('Error', 'An unexpected error occurred: ${e.toString()}', snackPosition: SnackPosition.BOTTOM);
    }
  }


  Future<void> verifyPhoneNumber(String phoneNumber) async {
    Get.dialog(const Center(child: CircularProgressIndicator()), barrierDismissible: false);

    try {
      // 1. Firestore'da telefon numarasını kontrol et
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('phoneNumber', isEqualTo: phoneNumber.trim())
          .get(); // Boşluk karakterlerini temizle

      if (querySnapshot.docs.isEmpty) {
        // Eğer telefon numarası kayıtlı değilse hata göster
        Get.back();
        Get.snackbar('Error', 'This phone number is not registered.', snackPosition: SnackPosition.BOTTOM);
        return;
      }

      // 2. Telefon numarası kayıtlı ise doğrulama işlemini başlat
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          Get.offAll(() => const Main()); // Başarılı girişten sonra anasayfaya yönlendir
        },
        verificationFailed: (FirebaseAuthException e) {
          Get.back();
          Get.snackbar('Error', 'Verification failed: ${e.message}', snackPosition: SnackPosition.BOTTOM);
        },
        codeSent: (String verificationId, int? resendToken) {
          Get.back();
          Get.to(() => VerifyPhoneScreen(verificationId: verificationId));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Otomatik kod zaman aşımı
        },
      );
    } catch (e) {
      Get.back();
      Get.snackbar('Error', 'Failed to verify phone number: ${e.toString()}', snackPosition: SnackPosition.BOTTOM);
    }
  }





  bool checkIfLoggedIn() {
    return _auth.currentUser != null;
  }
}
