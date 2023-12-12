import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controller/add_task_controller.dart';
import 'package:task_manager/controller/auth_controller.dart';
import 'package:task_manager/controller/bottom_nav_controller.dart';
import 'package:task_manager/controller/cancelled_task_controller.dart';
import 'package:task_manager/controller/completed_task_controller.dart';
import 'package:task_manager/controller/login_controller.dart';
import 'package:task_manager/controller/new_task_controller.dart';
import 'package:task_manager/controller/progress_task_controller.dart';
import 'package:task_manager/controller/reset_pass_controller.dart';
import 'package:task_manager/controller/signup_controller.dart';
import 'package:task_manager/controller/task_controller.dart';
import 'package:task_manager/controller/task_summary_controller.dart';
import 'package:task_manager/controller/update_profile_controller.dart';
import 'package:task_manager/ui/screen/splash_screen.dart';

void main() {
  runApp(const TaskManagerApp());
}

class TaskManagerApp extends StatelessWidget {
  static GlobalKey<NavigatorState> navigationKey = GlobalKey();

  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigationKey,
      theme: ThemeData(
        primaryColor: Colors.green,
        primarySwatch: Colors.green,
        inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide.none)),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(10))),
      ),
      home: const SplashScreen(),
      initialBinding: ControllerBindings(),
    );
  }
}

class ControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(SignupController());
    Get.put(LoginController());
    Get.put(ResetPasswordController());
    Get.put(UpdateProfileController());
    Get.put(BottomNavController());
    Get.put(TaskSummaryController());
    Get.put(TaskController());
    Get.put(AddTaskController());
    Get.put(NewTaskController());
    Get.put(ProgressTaskController());
    Get.put(CompletedTaskController());
    Get.put(CancelledTaskController());
  }
}
