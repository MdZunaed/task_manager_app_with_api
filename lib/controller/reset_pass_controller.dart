import 'package:get/get.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';

class ResetPasswordController extends GetxController {
  bool _verifyEmailProcessing = false;
  bool _verifyOtpProcessing = false;
  bool _resetPasswordProcessing = false;
  String _errorMessage = "";

  bool get verifyEmailProcessing => _verifyEmailProcessing;

  bool get verifyOtpProcessing => _verifyOtpProcessing;

  bool get resetPasswordProcessing => _resetPasswordProcessing;

  String get errorMessage => _errorMessage;

  Future<bool> verifyEmail(String email) async {
    _verifyEmailProcessing = true;
    update();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.verifyEmail(email));
    _verifyEmailProcessing = false;
    update();
    if (response.isSuccess) {
      return true;
    } else {
      _errorMessage = "Something went error, try again";
      return false;
    }
  }

  Future<bool> verifyOtp(String email, String otp) async {
    _verifyOtpProcessing = true;
    update();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.verifyOtp(email, otp));
    _verifyOtpProcessing = false;
    update();
    if (response.isSuccess) {
      return true;
    } else {
      _errorMessage = "Something went error, try again";
      return false;
    }
  }

  Future<bool> resetPassword(String email, String otp, String password) async {
    _resetPasswordProcessing = true;
    update();
    final NetworkResponse response = await NetworkCaller().postRequest(
        Urls.resetPass,
        body: {"email": email, "OTP": otp, "password": password});
    _resetPasswordProcessing = false;
    update();
    if (response.jsonResponse['status'] == 'fail') {
      _errorMessage = "wrong email or otp, check again";
      return false;
    } else if (response.isSuccess) {
      return true;
    } else {
      _errorMessage = "Password reset failed, try again";
      return false;
    }
  }
}
