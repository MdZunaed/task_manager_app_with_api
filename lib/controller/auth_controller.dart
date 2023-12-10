import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/models/user_model.dart';

class AuthController extends GetxController {
  static String? token;
  UserModel? user;

  Future<void> saveUserInformation(String t, UserModel model) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString('token', t);
    await sp.setString('user', jsonEncode(model.toJson()));
    token = t;
    user = model;
    update();
  }

  Future<void> updateUserInformation(UserModel model) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString('user', jsonEncode(model.toJson()));
    user = model;
    update();
  }

  Future<void> initializeUserCache() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    token = sp.getString('token');
    user = UserModel.fromJson(jsonDecode(sp.getString('user') ?? '{}'));
    update();
  }

  Future<bool> checkAuthState() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString('token');
    if (token != null) {
      await initializeUserCache();
      return true;
    }
    return false;
  }

  static Future<void> clearAuthData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.clear();
    token = null;
  }
}
