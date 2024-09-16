import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do/screens/userscreens/loginscreen.dart';
import '../../screens/userscreens/verification_screen.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SignupController extends GetxController {

  // Observable değişkenler
  var username = ''.obs;
  var email = ''.obs;
  var password = ''.obs;
  var phoneNumber = ''.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Email ile kayıt olma fonksiyonu
  Future<void> signUpWithEmail(String email, String password, String username) async {
    try {
      // Firebase Authentication ile eposta ve şifreyi kullanarak kullanıcı oluşturma
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Kullanıcı profilini güncelleme (displayName olarak username ekleme)
      await userCredential.user?.updateProfile(displayName: username);

      // Kullanıcıyı Firestore'da kaydetme (uid, username, email)
      await _saveUserToFirestore(userCredential.user?.uid, username, email);

      Get.to(() => const LoginScreen());
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }



  // Firestore'a kullanıcı bilgilerini kaydetme (uid, username, email)
  Future<void> _saveUserToFirestore(String? uid, String username, String email) async {
    if (uid != null) {
      await _firestore.collection('users').doc(uid).set({
        'uid': uid,
        'username': username,
        'email': email,
      });
    }
  }




  // Telefon ile kayıt olma
  void signUpWithPhone() async {
    if (username.value.isNotEmpty && phoneNumber.value.isNotEmpty) {
      // Öncelikle telefon numarasının daha önce kullanılıp kullanılmadığını kontrol edin
      bool phoneExists = await _checkIfPhoneNumberExists(phoneNumber.value);
      if (phoneExists) {
        // Eğer telefon numarası zaten kayıtlıysa hata mesajı göster
        Get.snackbar('Error', 'This phone number is already registered.', snackPosition: SnackPosition.BOTTOM);
      } else {
        // Telefon numarası kayıtlı değilse doğrulama işlemini başlat
        verifyPhoneNumber(phoneNumber.value);
      }
    } else {
      Get.snackbar('Error', 'All fields are required');
    }
  }


// Firestore'da telefon numarasının var olup olmadığını kontrol eden fonksiyon
  Future<bool> _checkIfPhoneNumberExists(String phoneNumber) async {
    final querySnapshot = await _firestore
        .collection('users')
        .where('phoneNumber', isEqualTo: phoneNumber)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }


  //telefon ile doğrulama

  void verifyPhoneNumber(String phoneNumber) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Telefon numarası otomatik doğrulanırsa burada işlenir
        await FirebaseAuth.instance.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        Get.snackbar('Verification Failed', e.message ?? 'Unknown error occurred');
      },
      codeSent: (String verificationId, int? resendToken) {
        // Doğrulama kodu gönderildiyse
        Get.to(() => VerificationScreen(
          verificationId: verificationId,
          username: username.value,
        ));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
      },
    );
  }


  void verifyCode(String code, String verificationId, String username) async {
    final credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: code);

    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user != null) {

        // saveUserData fonksiyonunu çağırarak kullanıcı verisini kaydet
        await saveUserData(userCredential.user!.uid, username, userCredential.user!.phoneNumber ?? '');

        // Başarıyla giriş yaptıktan sonra LoginScreen'e yönlendir
        Get.offAll(() => const LoginScreen());
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }


  Future<void> saveUserData(String uid, String username, String phoneNumber) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'uid': uid,
        'username': username,
        'phoneNumber': phoneNumber,
      });
    } catch (e) {
      Get.snackbar('Error', 'Failed to save user data: $e');
    }
  }







}
