import 'package:flutter/material.dart';
import 'package:task_manager/ui/screen/splash_screen.dart';

void main() {
  runApp(const TaskManagerApp());
}

class TaskManagerApp extends StatelessWidget {
  static GlobalKey<NavigatorState> navigationKey = GlobalKey();

  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}
