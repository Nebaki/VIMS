import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
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
      var jsonResponse;
      print(body);
      var res = await http.post(
        url,
        body: body,
      );
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body.toString());
        if (data["status"] == true) {
          var token = data["data"]["access_token"];
          var name = data["data"]["user"]["name"];
          var email = data["data"]["user"]["email"];
          var phone = data["data"]["user"]["phone"];
          print(token);
          final SharedPreferences _prefs = await prefs;
          await _prefs.setString("token", token);
            await _prefs.setString("email", email);
          emailController.clear();
          passController.clear();
          Get.offAllNamed("/homepage");
        } else {
          throw jsonDecode(res.body)["message"] ?? "unknown error occured";
        }
        // print('Signup successfully');
        // Get.offAllNamed("/signin");
      } else {
        throw jsonDecode(res.body)["message"] ?? "unknown error occured";
        // Get.snackbar(
        //   "unsuccessfull signup",
        //   ".",
        //   icon: const CustomSurffixIcon(
        //     svgIcon: "assets/icons/Error.svg",
        //     color: Colors.red,
        //   ),
        //   snackPosition: SnackPosition.BOTTOM,
        // );
        // print(res.statusCode);
      }
    } catch (e) {
      Get.back();
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: Text("Error"),
              contentPadding: EdgeInsets.all(20),
              children: [Text(e.toString())],
            );
          });
    }
  }
}
