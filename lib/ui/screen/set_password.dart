import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controller/reset_pass_controller.dart';
import 'package:task_manager/ui/widget/body_bg.dart';
import 'package:task_manager/ui/widget/snack_message.dart';
import 'login_screen.dart';

class SetPassword extends StatefulWidget {
  final String email;
  final String otp;

  const SetPassword({super.key, required this.email, required this.otp});

  @override
  State<SetPassword> createState() => _SetPasswordState();
}

class _SetPasswordState extends State<SetPassword> {
  final TextEditingController passwordTEController = TextEditingController();
  final TextEditingController cPasswordTEController = TextEditingController();
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
                Text("Set Password",
                    style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 10),
                Text(
                    "Minimum length password 6 character with letter and number combination",
                    style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 16),
                TextFormField(
                    controller: passwordTEController,
                    validator: validator,
                    obscureText: true,
                    decoration: const InputDecoration(hintText: "Password")),
                const SizedBox(height: 10),
                TextFormField(
                    controller: cPasswordTEController,
                    validator: validator,
                    obscureText: true,
                    decoration:
                        const InputDecoration(hintText: "Confirm Password")),
                const SizedBox(height: 16),
                SizedBox(
                    width: double.infinity,
                    child:
                        GetBuilder<ResetPasswordController>(builder: (context) {
                      return Visibility(
                        visible: controller.resetPasswordProcessing == false,
                        replacement:
                            const Center(child: CircularProgressIndicator()),
                        child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                resetPassword();
                              }
                            },
                            // onPressed: () {
                            //   if (passwordTEController.text !=
                            //       cPasswordTEController.text) {
                            //     showSnackMessage(
                            //         context, 'password do not match');
                            //   } else if (formKey.currentState!.validate()) {
                            //     resetPassword();
                            //   }
                            // },
                            child: const Text("Confirm")),
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

  Future<void> resetPassword() async {
    final response = await controller.resetPassword(
        widget.email, widget.otp, passwordTEController.text);
    if (response) {
      if (mounted) {
        showSnackMessage(context, "Password reset success");
      }
      Get.offAll(const LoginScreen());
    } else {
      if (mounted) {
        showSnackMessage(context, controller.errorMessage, true);
      }
    }
  }

  String? validator(String? value) {
    if (value?.isEmpty ?? true) {
      return 'enter valid value';
    } else if (value!.trim().length < 6) {
      return "password should be minimum 6 digit";
    } else if (passwordTEController.text != cPasswordTEController.text) {
      return "password do not match";
    }
    return null;
  }
}
