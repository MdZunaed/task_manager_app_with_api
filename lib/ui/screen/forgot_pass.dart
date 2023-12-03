import 'package:flutter/material.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';
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
  bool verifyEmailProcessing = false;

  Future<void> verifyEmail() async {
    verifyEmailProcessing = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response = await NetworkCaller()
        .getRequest(Urls.verifyEmail(emailTEController.text.trim()));
    if (response.isSuccess) {
      verifyEmailProcessing = false;
      if (mounted) {
        setState(() {});
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    OtpScreen(email: emailTEController.text.trim())));
      }
    } else {
      if (mounted) {
        showSnackMessage(context, "Something went error, try again", true);
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
                    child: Visibility(
                      visible: verifyEmailProcessing == false,
                      replacement:
                          const Center(child: CircularProgressIndicator()),
                      child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              verifyEmail();
                            }
                          },
                          child: const Icon(Icons.arrow_circle_right_outlined)),
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
}
