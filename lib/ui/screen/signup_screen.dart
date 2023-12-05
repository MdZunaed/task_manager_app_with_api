import 'package:flutter/material.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/ui/widget/body_bg.dart';
import 'package:task_manager/ui/widget/snack_message.dart';

import '../../data/network_caller/network_response.dart';
import '../../data/utility/urls.dart';
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
  final TextEditingController mobileNoTEController = TextEditingController();
  final TextEditingController passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool signupProcessing = false;

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
                    controller: mobileNoTEController,
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
                    child: signupProcessing
                        ? const Center(child: CircularProgressIndicator())
                        : ElevatedButton(
                            onPressed: _signUp,
                            child:
                                const Icon(Icons.arrow_circle_right_outlined))),
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
      ),
    );
  }

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      signupProcessing = true;
      if (mounted) {
        setState(() {});
      }
      final NetworkResponse response =
          await NetworkCaller().postRequest(Urls.registration, body: {
        "email": emailTEController.text.trim(),
        "firstName": firstNameTEController.text.trim(),
        "lastName": lastNameTEController.text.trim(),
        "mobile": mobileNoTEController.text.trim(),
        "password": passwordTEController.text,
        "photo": ""
      });
      signupProcessing = false;
      if (mounted) {
        setState(() {});
      }

      if (response.isSuccess) {
        _clearTextFields();
        if (mounted) {
          showSnackMessage(context, "Account has been created! please Sign in");
        }
      }
    } else {
      signupProcessing = false;
      setState(() {});
      if (mounted) {
        showSnackMessage(
            context, "Account creation failed! please try again", true);
      }
    }
  }

  void _clearTextFields() {
    emailTEController.clear();
    firstNameTEController.clear();
    lastNameTEController.clear();
    mobileNoTEController.clear();
    passwordTEController.clear();
  }

  @override
  void dispose() {
    emailTEController.dispose();
    firstNameTEController.dispose();
    lastNameTEController.dispose();
    mobileNoTEController.dispose();
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
