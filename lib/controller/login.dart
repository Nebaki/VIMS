import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_app/screen/home/hompage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Componets/Custom_Icons.dart';
import '../util/api_endpoints.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  Future<void> login() async {
    try {
      var url =
          Uri.parse(ApiEndPoints.baseurl + ApiEndPoints.authendpoints.login);

      Map body = {
        "phone": phoneController.text,
        "password": passController.text,
      };
      print(body);
      var res = await http.post(
        url,
        body: body,
      );
      var data = jsonDecode(res.body.toString());
      if (res.statusCode == 200) {
        if (data["status"] == true) {
          var token = data["data"]["access_token"];
          var email = data["data"]["user"]["email"];
          var name = data["data"]["user"]["name"];
          var phone = data["data"]["user"]["phone"];
          print(token);
          final SharedPreferences _prefs = await prefs;
          await _prefs.setString("token", token);
          await _prefs.setString("email", email);
          emailController.clear();
          passController.clear();
          Get.rawSnackbar(
              message: data["message"], duration: Duration(seconds: 2));
          Get.offAllNamed("/homepage");
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
