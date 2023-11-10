import 'package:flutter/material.dart';
import 'package:task_manager/ui/screen/main_nav_screen.dart';
import 'package:task_manager/ui/screen/forgot_pass.dart';
import 'package:task_manager/ui/screen/signup_screen.dart';
import 'package:task_manager/ui/widget/body_bg.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 100),
              Text("Get Stared With",
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 16),
              TextFormField(
                  decoration: const InputDecoration(hintText: "Email")),
              const SizedBox(height: 16),
              TextFormField(
                  decoration: const InputDecoration(hintText: "Password")),
              const SizedBox(height: 16),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BottomNavScreen()));
                      },
                      child: const Icon(Icons.arrow_circle_right_outlined))),
              const SizedBox(height: 30),
              Center(
                child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ForgotPassword()));
                    },
                    child: const Text("Forget Password?")),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text("Don't have an account?"),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignupScreen()));
                    },
                    child: const Text("Sign up",
                        style: TextStyle(fontWeight: FontWeight.bold)))
              ])
            ],
          ),
        ),
      ),
    );
  }
}
