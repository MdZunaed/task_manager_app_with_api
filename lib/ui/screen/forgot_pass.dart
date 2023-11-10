import 'package:flutter/material.dart';
import 'package:task_manager/ui/screen/otp_screen.dart';
import 'package:task_manager/ui/widget/body_bg.dart';

import 'login_screen.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

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
              Text("Your Email Address",
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 10),
              Text("A 6 digit verification pin will send to your email address",
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 16),
              TextFormField(
                  decoration: const InputDecoration(hintText: "Email")),
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
