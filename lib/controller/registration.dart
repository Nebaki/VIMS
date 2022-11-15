import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../util/api_endpoints.dart';

class RegistrationController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String? role;

  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  Future<void> register() async {
    try {
      var url =
          Uri.parse(ApiEndPoints.baseurl + ApiEndPoints.authendpoints.register);

      Map body = {
        "email": emailController.text,
        "password": passController.text,
        "name": fullNameController.text,
        "phone": phoneController.text,
        "role": role
      };
      var jsonResponse;
      print(body);
      var res = await http.post(
        url,
        body: body,
      );
      var data = jsonDecode(res.body.toString());
      if (res.statusCode == 200) {
        if (data["status"] == true) {
          var token = data["data"]["access_token"];
          print(res.body);
          print(token);
          final SharedPreferences _prefs = await prefs;
          await _prefs.setString("token", token);
          emailController.clear();
          passController.clear();
          phoneController.clear();
          fullNameController.clear();
          Get.rawSnackbar(
              message: data["message"], duration: Duration(seconds: 2));
          Get.offAllNamed("/signin");
        } else {
          Get.rawSnackbar(
              message: data["message"], duration: Duration(seconds: 2));
        }
      } else {
        Get.rawSnackbar(
            message: data["message"], duration: Duration(seconds: 2));
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
