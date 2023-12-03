import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/ui/screen/set_password.dart';
import 'package:task_manager/ui/widget/body_bg.dart';

import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utility/urls.dart';
import '../widget/snack_message.dart';
import 'login_screen.dart';

class OtpScreen extends StatefulWidget {
  final String email;

  const OtpScreen({super.key, required this.email});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController otpTEController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  bool verifyOtpProcessing = false;

  Future<void> verifyOtp() async {
    verifyOtpProcessing = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response = await NetworkCaller()
        .getRequest(Urls.verifyOtp(widget.email, otpTEController.text.trim()));
    if (response.isSuccess) {
      verifyOtpProcessing = false;
      if (mounted) {
        setState(() {});
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SetPassword(
                      email: widget.email,
                      otp: otpTEController.text,
                    )));
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
                Text("Pin verification",
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 10),
                Text(
                    "A 6 digit verification pin will send to your email address",
                    style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 16),
                PinCodeTextField(
                  controller: otpTEController,
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter otp first';
                    } else if (value?.trim().length != 6) {
                      return 'OTP should be 6 digit';
                    }
                    return null;
                  },
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
                    child: Visibility(
                      visible: verifyOtpProcessing == false,
                      replacement:
                          const Center(child: CircularProgressIndicator()),
                      child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              verifyOtp();
                            }
                          },
                          child: const Text("Verify")),
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
