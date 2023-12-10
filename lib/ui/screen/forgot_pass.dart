import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controller/reset_pass_controller.dart';
import 'package:task_manager/ui/screen/otp_screen.dart';
import 'package:task_manager/ui/widget/body_bg.dart';
import 'package:task_manager/ui/widget/snack_message.dart';

import 'login_screen.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController emailTEController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  ResetPasswordController controller = Get.find<ResetPasswordController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                Text("Your Email Address",
                    style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 10),
                Text(
                    "A 6 digit verification pin will send to your email address",
                    style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 16),
                TextFormField(
                    controller: emailTEController,
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter email first';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(hintText: "Email")),
                const SizedBox(height: 16),
                SizedBox(
                    width: double.infinity,
                    child: GetBuilder<ResetPasswordController>(
                        builder: (controller) {
                      return Visibility(
                        visible: controller.verifyEmailProcessing == false,
                        replacement:
                            const Center(child: CircularProgressIndicator()),
                        child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                verifyEmail();
                              }
                            },
                            child:
                                const Icon(Icons.arrow_circle_right_outlined)),
                      );
                    })),
                const SizedBox(height: 30),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text("Have an account?"),
                  TextButton(
                      onPressed: () {
                        Get.to(const LoginScreen());
                      },
                      child: const Text("Sign in",
                          style: TextStyle(fontWeight: FontWeight.bold)))
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> verifyEmail() async {
    final response =
        await controller.verifyEmail(emailTEController.text.trim());
    if (response) {
      Get.to(OtpScreen(email: emailTEController.text.trim()));
    } else {
      if (mounted) {
        showSnackMessage(context, controller.errorMessage, true);
      }
    }
  }
}
