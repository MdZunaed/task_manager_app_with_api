import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:task_manager/controller/auth_controller.dart';
import 'package:task_manager/main.dart';
import 'package:task_manager/ui/screen/login_screen.dart';
import 'network_response.dart';

class NetworkCaller {
  Future<NetworkResponse> postRequest(String url,
      {Map<String, dynamic>? body, bool isLogin = false}) async {
    try {
      log(url);
      log(body.toString());
      final Response response =
          await post(Uri.parse(url), body: jsonEncode(body), headers: {
        'Content-type': 'Application/json',
        'token': AuthController.token.toString(),
      });
      log(response.statusCode.toString());
      log(response.headers.toString());
      log(response.body);
      if (response.statusCode == 200) {
        return NetworkResponse(
            statusCode: 200,
            isSuccess: true,
            jsonResponse: jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        if (isLogin == false) {
          backToLogin();
        }
        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            jsonResponse: jsonDecode(response.body));
      } else {
        return NetworkResponse(
            statusCode: response.statusCode,
            isSuccess: false,
            jsonResponse: jsonDecode(response.body));
      }
    } catch (e) {
      return NetworkResponse(isSuccess: false, errorMessage: e.toString());
    }
  }

  Future<NetworkResponse> getRequest(String url) async {
    try {
      log(url);
      final Response response = await get(Uri.parse(url), headers: {
        'Content-type': 'Application/json',
        'token': AuthController.token.toString(),
      });
      log(response.statusCode.toString());
      log(response.headers.toString());
      log(response.body);
      if (response.statusCode == 200) {
        return NetworkResponse(
            statusCode: 200,
            isSuccess: true,
            jsonResponse: jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        backToLogin();
        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            jsonResponse: jsonDecode(response.body));
      } else {
        return NetworkResponse(
            statusCode: response.statusCode,
            isSuccess: false,
            jsonResponse: jsonDecode(response.body));
      }
    } catch (e) {
      return NetworkResponse(isSuccess: false, errorMessage: e.toString());
    }
  }

  void backToLogin() async {
    await AuthController.clearAuthData();
    Navigator.pushAndRemoveUntil(
        TaskManagerApp.navigationKey.currentContext!,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false);
  }
}
