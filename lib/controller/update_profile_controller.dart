import 'dart:convert';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/controller/auth_controller.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/models/user_model.dart';

class UpdateProfileController extends GetxController {
  //XFile? photo;
  AuthController authController = Get.find<AuthController>();
  bool updateProfileProcessing = false;
  String _message = "";

  String get message => _message;

  Future<bool> updateProfile(String email, String firstName, String lastName,
      String mobile, String password, XFile? photo) async {
    updateProfileProcessing = true;
    update();
    String? photoInBase64;
    Map<String, dynamic> inputData = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
    };
    if (password.isNotEmpty) {
      inputData['password'] = password;
    }
    if (photo != null) {
      List<int> imageBytes = await photo.readAsBytes();
      photoInBase64 = base64Encode(imageBytes);
      inputData['photo'] = photoInBase64;
    }
    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.updateProfile, body: inputData);
    updateProfileProcessing = false;
    update();
    if (response.isSuccess) {
      authController.updateUserInformation(UserModel(
          email: email,
          firstName: firstName,
          lastName: lastName,
          mobile: mobile,
          photo: photoInBase64 ?? authController.user?.photo));

      _message = "profile updated successfully";
      return true;
    } else {
      _message = "update failed, try again";
      return false;
    }
  }
}
