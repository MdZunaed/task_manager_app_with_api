import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/ui/widget/body_bg.dart';

import 'login_screen.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

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
              Text("Pin verification",
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 10),
              Text("A 6 digit verification pin will send to your email address",
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 16),
              PinCodeTextField(
                appContext: context,
                length: 6,
                keyboardType: TextInputType.number,
                animationType: AnimationType.fade,
                separatorBuilder: (c, i) => const SizedBox(width: 6),
                pinTheme: PinTheme(
                    activeFillColor: Colors.green,
                    inactiveColor: Colors.white,
                    shape: PinCodeFieldShape.box,
                    selectedFillColor: Colors.greenAccent,
                    inactiveFillColor: Colors.lightGreenAccent),
                animationDuration: const Duration(milliseconds: 200),
                enableActiveFill: true,
                backgroundColor: Colors.transparent,
              ),
              const SizedBox(height: 16),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {}, child: const Text("Verify"))),
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
