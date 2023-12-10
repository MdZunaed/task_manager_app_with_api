import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controller/bottom_nav_controller.dart';
import 'package:task_manager/ui/screen/cancelled_task.dart';
import 'package:task_manager/ui/screen/completed_task.dart';
import 'package:task_manager/ui/screen/new_task_list.dart';

import 'progress_task.dart';

class BottomNavScreen extends StatelessWidget {
  const BottomNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List screens = [
      const NewTaskScreen(),
      const ProgressTaskScreen(),
      const CompletedTaskScreen(),
      const CancelledTaskScreen(),
    ];
    return Scaffold(
      bottomNavigationBar:
          GetBuilder<BottomNavController>(builder: (navController) {
        return BottomNavigationBar(
          currentIndex: navController.currentIndex,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          onTap: (index) {
            navController.changeScreen(index);
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.add_box), label: "New"),
            BottomNavigationBarItem(
                icon: Icon(Icons.change_circle), label: "In progress"),
            BottomNavigationBarItem(
                icon: Icon(Icons.done_outline), label: "Completed"),
            BottomNavigationBarItem(icon: Icon(Icons.close), label: "Canceled"),
          ],
        );
      }),
      body: GetBuilder<BottomNavController>(builder: (controller) {
        return screens.elementAt(controller.currentIndex);
      }),
    );
  }
}
