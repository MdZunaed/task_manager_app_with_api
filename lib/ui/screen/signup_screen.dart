import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controller/signup_controller.dart';
import 'package:task_manager/ui/widget/body_bg.dart';
import 'package:task_manager/ui/widget/snack_message.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailTEController = TextEditingController();
  final TextEditingController firstNameTEController = TextEditingController();
  final TextEditingController lastNameTEController = TextEditingController();
  final TextEditingController mobileTEController = TextEditingController();
  final TextEditingController passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  SignupController signupController = Get.find<SignupController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                Text("Join With Us",
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 16),
                TextFormField(
                    controller: emailTEController,
                    validator: validator,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(hintText: "Email")),
                const SizedBox(height: 16),
                TextFormField(
                    controller: firstNameTEController,
                    validator: validator,
                    decoration: const InputDecoration(hintText: "First Name")),
                const SizedBox(height: 16),
                TextFormField(
                    controller: lastNameTEController,
                    validator: validator,
                    decoration: const InputDecoration(hintText: "Last Name")),
                const SizedBox(height: 16),
                TextFormField(
                    controller: mobileTEController,
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter phone number';
                      }
                      if (value!.length != 11) {
                        return 'phone number should be 11 letters';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(hintText: "Mobile")),
                const SizedBox(height: 16),
                TextFormField(
                    controller: passwordTEController,
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter password';
                      }
                      if (value!.length < 6) {
                        return 'password should be minimum 6 letters';
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: const InputDecoration(hintText: "Password")),
                const SizedBox(height: 16),
                SizedBox(
                    width: double.infinity,
                    child: GetBuilder<SignupController>(builder: (controller) {
                      return Visibility(
                        visible: controller.signupProcessing == false,
                        replacement:
                            const Center(child: CircularProgressIndicator()),
                        child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                signup();
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

  Future<void> signup() async {
    final response = await signupController.signUp(
        emailTEController.text.trim(),
        firstNameTEController.text.trim(),
        lastNameTEController.text.trim(),
        mobileTEController.text.trim(),
        passwordTEController.text.trim());
    if (response) {
      _clearTextFields();
      if (mounted) {
        showSnackMessage(context, signupController.message);
      }
    } else {
      if (mounted) {
        showSnackMessage(context, signupController.message, true);
      }
    }
  }

  void _clearTextFields() {
    emailTEController.clear();
    firstNameTEController.clear();
    lastNameTEController.clear();
    mobileTEController.clear();
    passwordTEController.clear();
  }

  @override
  void dispose() {
    emailTEController.dispose();
    firstNameTEController.dispose();
    lastNameTEController.dispose();
    mobileTEController.dispose();
    passwordTEController.dispose();
    super.dispose();
  }
}

String? validator(String? value) {
  if (value?.trim().isEmpty ?? true) {
    return "Enter valid value";
  }
  return null;
}
