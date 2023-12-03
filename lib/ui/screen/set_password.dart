import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';
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
  bool resetPasswordProcessing = false;

  Future<void> resetPassword() async {
    resetPasswordProcessing = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response = await NetworkCaller()
        .postRequest(Urls.resetPass, body: {
      "email": widget.email,
      "OTP": widget.otp,
      "password": passwordTEController.text
    });
    resetPasswordProcessing = false;
    if (mounted) {
      setState(() {});
    }
    if (response.jsonResponse['status'] == 'fail') {
      resetPasswordProcessing = false;
      if (mounted) {
        setState(() {});
        showSnackMessage(context, "wrong email or otp check again", true);
      }
    } else if (response.isSuccess) {
      if (mounted) {
        showSnackMessage(context, "Password reset success");
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false);
      }
    } else {
      if (mounted) {
        showSnackMessage(
            context, "Password reset failed, check email or otp", true);
      }
    }
  }

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
                    child: Visibility(
                      visible: resetPasswordProcessing == false,
                      replacement:
                          const Center(child: CircularProgressIndicator()),
                      child: ElevatedButton(
                          onPressed: () {
                            if (passwordTEController.text.trim() !=
                                cPasswordTEController.text.trim()) {
                              showSnackMessage(
                                  context, 'password do not match');
                            } else if (formKey.currentState!.validate()) {
                              resetPassword();
                            }
                          },
                          child: const Text("Confirm")),
                    )),
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

  String? validator(String? value) {
    if (value?.isEmpty ?? true) {
      return 'enter valid value';
    } else if (value!.trim().length < 6) {}
    return null;
  }
}
