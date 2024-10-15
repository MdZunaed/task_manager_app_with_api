import 'package:get/get.dart';

import '../data/network_caller/network_caller.dart';
import '../data/network_caller/network_response.dart';
import '../data/utility/urls.dart';
import '../models/user_model.dart';
import 'auth_controller.dart';

class LoginController extends GetxController {
  bool _loginProcessing = false;
  String _errorMessage = '';

  bool get loginProcessing => _loginProcessing;

  String get errorMessage => _errorMessage;

  Future<bool> login(String email, String password) async {
    _loginProcessing = true;
    update();
    NetworkResponse response = await NetworkCaller().postRequest(Urls.login,
        body: {
          "email": email,
          "password": password,
        },
        isLogin: true);
    _loginProcessing = false;
    update();
    if (response.isSuccess) {
      await Get.find<AuthController>().saveUserInformation(
          response.jsonResponse['token'], UserModel.fromJson(response.jsonResponse['data'][0]));
      return true;
    } else {
      if (response.statusCode == 401) {
        _errorMessage = 'Please check email or password';
      } else {
        _errorMessage = 'Login failed, please try again';
      }
    }
    return false;
  }
}
