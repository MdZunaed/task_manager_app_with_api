import 'package:get/get.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';

class SignupController extends GetxController {
  bool _signupProcessing = false;
  String _message = "";

  bool get signupProcessing => _signupProcessing;

  String get message => _message;

  Future<bool> signUp(String email, String firstName, String lastName,
      String mobile, String password) async {
    _signupProcessing = true;
    update();
    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.registration, body: {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "password": password,
      "photo": ""
    });
    _signupProcessing = false;
    update();

    if (response.isSuccess) {
      //_clearTextFields();
      _message = "Account has been created! please Sign in";
      update();
      return true;
    } else {
      _message = "Account has been created! please Sign in";
      update();
      return false;
    }
  }
}
