import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../../../main/main_controller.dart';
import '../../userscreens/loginscreen.dart';

class UserController extends GetxController {

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Rx<File?> _imageFile = Rx<File?>(null);

  Rx<String> username = ''.obs;
  Rx<String> profilePhotoUrl = ''.obs;
  Rx<String> email = ''.obs;
  Rx<String> phoneNumber = ''.obs;

  void resetSelectedIndex() {
    final MainController mainController = Get.find();
    mainController.selectedIndex.value = 0;
  }

  @override
  void onInit() {
    super.onInit();
    auth.userChanges().listen((User? user) {
      if (user != null) {
        resetSelectedIndex();  // SelectedIndex'i sıfırla
        _fetchUserProfile(user.uid);
      } else {
        _clearUserData();
      }
    });
  }
  void _clearUserData() {
    username.value = '';
    profilePhotoUrl.value = '';
    email.value = '';
    phoneNumber.value = '';
  }

  void _fetchUserProfile(String userId) async {
    try {
      final userDoc = await _firestore.collection('users').doc(userId).get();

      if (userDoc.exists && userDoc.data() != null) {
        final userData = userDoc.data()!;

        username.value = userData['username'] ?? '';
        profilePhotoUrl.value = userData['profilePhotoUrl'] ?? '';

        // phoneNumber kontrolü
        if (userData.containsKey('phoneNumber')) {
          phoneNumber.value = userData['phoneNumber'] ?? '';
        } else {
          phoneNumber.value = '';  // phoneNumber yoksa boş atanıyor
        }
        // email kontrolü
        email.value = userData['email'] ?? '';
      }
    } catch (e) {
      print('Error fetching user profile: $e');
    }
  }




  void deleteAccount(BuildContext context) async {
    final userId = auth.currentUser?.uid;

    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Önce oturum açmalısınız.'),
        ),
      );
      return;
    }

    try {
      // Kullanıcıyı ve kullanıcı belgesini silme
      await deleteUserSubcollections(userId);
      await auth.currentUser!.delete();
      await _firestore.collection('users').doc(userId).delete();
      await signOut();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Hesabınız başarıyla silindi.'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Hesap silme işlemi sırasında bir hata oluştu: $e'),
        ),
      );
    }
  }

  Future<void> deleteUserSubcollections(String userId) async {
    // Alt koleksiyonları ve belgeleri manuel olarak silin
    // Burada alt koleksiyonları elle silebilirsiniz
    final profileRef = _firestore.collection('users').doc(userId).collection('tasks');
    final postsRef = _firestore.collection('users').doc(userId).collection('completedtasks');

    await _deleteCollection(profileRef);
    await _deleteCollection(postsRef);
  }

  Future<void> _deleteCollection(CollectionReference collectionRef) async {
    final snapshot = await collectionRef.get();
    final batch = _firestore.batch();

    for (final doc in snapshot.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  }






  Future<void> updateProfile(String newUsername) async {
    final userId = auth.currentUser!.uid;
    try {
      await _firestore.collection('users').doc(userId).update({
        'username': newUsername,
      });
      username.value = newUsername;
      Get.snackbar(
        'Success',
        'Username updated successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update username: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }


  Future<void> updateProfilePhoto(String photoUrl) async {
    final userId = auth.currentUser!.uid;
    await _firestore.collection('users').doc(userId).update({
      'profilePhotoUrl': photoUrl,
    });
    profilePhotoUrl.value = photoUrl;
  }

  Future<void> changePassword(String oldPassword, String newPassword) async {
    final user = auth.currentUser!;
    final cred = EmailAuthProvider.credential(
        email: user.email!, password: oldPassword);

    // Boş alanları kontrol et
    if (oldPassword.isEmpty || newPassword.isEmpty) {
      Get.snackbar(
        'Error',
        'Both password fields must be filled.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      return;
    }

    try {
      // Yeniden kimlik doğrulaması
      await user.reauthenticateWithCredential(cred);
      // Şifreyi güncelle
      await user.updatePassword(newPassword);


      Get.back();
      // Şifre başarıyla değiştirildiğinde mesaj göster ve geri dön
      Get.snackbar(
        'Success',
        'Password changed successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      if (e is FirebaseAuthException) {
        // Firebase kimlik doğrulama hatalarını ele al
        if (e.code == 'wrong-password') {
          Get.snackbar(
            'Error',
            'The old password is incorrect.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: const Duration(seconds: 3),
          );
        } else if (e.code == 'weak-password') {
          Get.snackbar(
            'Error',
            'The new password is too weak.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: const Duration(seconds: 3),
          );
        } else {
          Get.snackbar(
            'Error',
            'Failed to change password: ${e.message}',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: const Duration(seconds: 3),
          );
        }
      } else {
        // Genel hata durumu
        Get.snackbar(
          'Error',
          'An unexpected error occurred: ${e.toString()}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      }
    }
  }


  Future<void> signOut() async {
    try {
      await auth.signOut();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      Get.snackbar('Error', 'Failed to sign out: ${e.toString()}');
    }
  }

  final RxString tempImageUrl = ''.obs;  // Geçici URL

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _imageFile.value = File(pickedFile.path);
      // Seçilen resim hemen avatar içinde görünsün
      tempImageUrl.value = _imageFile.value!.path;

      // Yükleme ve URL kaydetme işlemi yalnızca uploadImageAndSaveURL'de yapılacak
      await uploadImageAndSaveURL();
    }
  }





  Future<void> uploadImageAndSaveURL() async {
    if (_imageFile.value == null) return;

    final userId = auth.currentUser!.uid;
    final storageRef = FirebaseStorage.instance.ref()
        .child('profile_photos')
        .child('$userId.jpg');

    try {
      final uploadTask = storageRef.putFile(_imageFile.value!);
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();

      await updateProfilePhoto(downloadUrl);

      Get.snackbar(
        'Success',
        'Profile photo updated successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update profile photo: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
