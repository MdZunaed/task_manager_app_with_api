import 'package:flutter/material.dart';
import 'package:task_manager/controller/auth_controller.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/models/user_model.dart';
import 'package:task_manager/ui/screen/main_nav_screen.dart';
import 'package:task_manager/ui/screen/forgot_pass.dart';
import 'package:task_manager/ui/screen/signup_screen.dart';
import 'package:task_manager/ui/widget/body_bg.dart';
import 'package:task_manager/ui/widget/snack_message.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  bool loginProcessing = false;

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
                    style: Theme
                        .of(context)
                        .textTheme
                        .headlineMedium),
                const SizedBox(height: 16),
                TextFormField(
                    controller: emailController,
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter email';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(hintText: "Email")),
                const SizedBox(height: 16),
                TextFormField(
                    controller: passwordController,
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
                    child: loginProcessing
                        ? const Center(child: CircularProgressIndicator())
                        : ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            login();
                          }
                        },
                        child:
                        const Icon(Icons.arrow_circle_right_outlined))),
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
      ),
    );
  }

  Future<void> login() async {
    loginProcessing = true;
    if (mounted) {
      setState(() {});
    }
    NetworkResponse response = await NetworkCaller().postRequest(Urls.login,
        body: {
          "email": emailController.text.trim(),
          "password": passwordController.text
        });
    loginProcessing = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      await AuthController.saveUserInformation(response.jsonResponse['token'],
          UserModel.fromJson(response.jsonResponse['data']));
      if (mounted) {
        showSnackMessage(context, 'Logged in successfully');
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const BottomNavScreen()));
      }
    } else {
      if (response.statusCode == 401) {
        if (mounted) {
          showSnackMessage(context, 'Please check email or password', true);
        }
      } else {
        if (mounted) {
          showSnackMessage(context, 'Login failed, please try again', true);
        }
      }
    }
  }


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
