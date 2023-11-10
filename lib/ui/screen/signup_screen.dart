import 'package:flutter/material.dart';
import 'package:task_manager/ui/screen/otp_screen.dart';
import 'package:task_manager/ui/widget/body_bg.dart';

import 'login_screen.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

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
              Text("Join With Us",
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 16),
              TextFormField(
                  decoration: const InputDecoration(hintText: "Email")),
              const SizedBox(height: 16),
              TextFormField(
                  decoration: const InputDecoration(hintText: "First Name")),
              const SizedBox(height: 16),
              TextFormField(
                  decoration: const InputDecoration(hintText: "Last Name")),
              const SizedBox(height: 16),
              TextFormField(
                  decoration: const InputDecoration(hintText: "Mobile")),
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
                                builder: (context) => const OtpScreen()));
                      },
                      child: const Icon(Icons.arrow_circle_right_outlined))),
              const SizedBox(height: 30),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text("Have an account?"),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                    child: const Text("Sign in",
                        style: TextStyle(fontWeight: FontWeight.bold)))
              ])
            ],
          ),
        ),
      ),
    );
  }
}
