import 'package:flutter/material.dart';
import 'package:task_manager/ui/screen/cancelled_task.dart';
import 'package:task_manager/ui/screen/completed_task.dart';
import 'package:task_manager/ui/screen/new_task.dart';

import 'progress_task.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int selectedIndex = 0;
  List screens = [
    const NewTaskScreen(),
    const ProgressTaskScreen(),
    const CompletedTaskScreen(),
    const CancelledTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: (index) {
          selectedIndex = index;
          setState(() {});
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.add_box), label: "New"),
          BottomNavigationBarItem(
              icon: Icon(Icons.change_circle), label: "In progress"),
          BottomNavigationBarItem(
              icon: Icon(Icons.done_outline), label: "Completed"),
          BottomNavigationBarItem(icon: Icon(Icons.close), label: "Canceled"),
        ],
      ),
      body: screens[selectedIndex],
    );
  }
}
