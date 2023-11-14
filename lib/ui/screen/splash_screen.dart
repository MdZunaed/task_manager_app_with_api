import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager/controller/auth_controller.dart';
import 'package:task_manager/ui/screen/login_screen.dart';
import 'package:task_manager/ui/screen/main_nav_screen.dart';
import 'package:task_manager/ui/widget/body_bg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    goToLogin();
    super.initState();
  }

  void goToLogin() async {
    final bool isLoggedIn = await AuthController.checkAuthState();
    Future.delayed(const Duration(seconds: 1)).then((value) =>
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    isLoggedIn ? const BottomNavScreen() : const LoginScreen()),
            (route) => false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BodyBackground(
      child: Center(child: SvgPicture.asset("assets/images/logo.svg")),
    ));
  }
}
