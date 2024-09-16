import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:to_do/controllers/addtask_controller.dart';
import 'package:to_do/controllers/completedtask_controller.dart';
import 'package:to_do/controllers/users_controllers/login_controller.dart';
import 'package:to_do/controllers/users_controllers/signup_controller.dart';
import 'package:to_do/main/appBar.dart';
import 'package:to_do/main/loading.dart';
import 'package:to_do/screens/homescreen/homescreen.dart';
import 'package:to_do/screens/completedtaskscreen/completedtaskscreen.dart';
import 'package:to_do/screens/settingscreen/scontrollers/user_controller.dart';
import 'package:to_do/screens/settingscreen/settingscreen.dart';
import 'constants/colors.dart';
import 'controllers/home_controller.dart';
import 'main/drawer.dart';
import 'main/main_controller.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Global olarak Controller'ları tanımlama
  Get.put(LoginController());
  Get.put(SignupController());
  Get.put(HomeController());
  Get.put(CompletedTaskController());
  Get.put(AddTaskController());
  Get.put(MainController());

  //settings
  Get.put(UserController());

  runApp(const MyApp());
}




class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoadingScreen(),
    );
  }
}





class Main extends StatelessWidget {

  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    final MainController controller = Get.find();

    final List<Widget> screens = [
      Home(),
      CompletedTask(),
      const SettingsScreen(),
    ];

    return Scaffold(

      extendBodyBehindAppBar: true,

      appBar: AppBarContent(),

      drawer: buildDrawer(),

      body: Obx(() {
        return screens[controller.selectedIndex.value];
      }),
    );
  }
}

