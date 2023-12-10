import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/screen/bottom_nav_screen.dart';
import 'package:task_manager/ui/screen/forgot_pass.dart';
import 'package:task_manager/ui/screen/signup_screen.dart';
import 'package:task_manager/ui/widget/body_bg.dart';
import 'package:task_manager/ui/widget/snack_message.dart';
import '../../controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailTEController = TextEditingController();
  final TextEditingController passwordTEController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  final loginController = Get.find<LoginController>();

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
                Text("Get Stared With",
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 16),
                TextFormField(
                    controller: emailTEController,
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter email';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(hintText: "Email")),
                const SizedBox(height: 16),
                TextFormField(
                    obscureText: true,
                    controller: passwordTEController,
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter password';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(hintText: "Password")),
                const SizedBox(height: 16),
                SizedBox(
                    width: double.infinity,
                    child: GetBuilder<LoginController>(
                      builder: (controller) {
                        return Visibility(
                            visible: controller.loginProcessing == false,
                            replacement: const Center(
                                child: CircularProgressIndicator()),
                            child: ElevatedButton(
                              onPressed: login,
                              child:
                                  const Icon(Icons.arrow_circle_right_outlined),
                            ));
                      },
                    )),
                const SizedBox(height: 30),
                Center(
                  child: TextButton(
                      onPressed: () {
                        Get.to(const ForgotPassword());
                      },
                      child: const Text("Forget Password?")),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text("Don't have an account?"),
                  TextButton(
                      onPressed: () {
                        Get.to(const SignupScreen());
                      },
                      child: const Text("Sign up",
                          style: TextStyle(fontWeight: FontWeight.bold)))
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      final response = await loginController.login(
          emailTEController.text.trim(), passwordTEController.text.trim());
      if (response) {
        if (mounted) {
          showSnackMessage(context, 'Logged in successfully');
          Get.offAll(const BottomNavScreen());
        }
      } else {
        if (mounted) {
          showSnackMessage(context, loginController.errorMessage, true);
        }
      }
    }
  }

  @override
  void dispose() {
    emailTEController.dispose();
    passwordTEController.dispose();
    super.dispose();
  }
}
