import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../util/api_endpoints.dart';

class ResetPassController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passController = TextEditingController();

  Future<void> Reset() async {
    try {
      var url =
          Uri.parse(ApiEndPoints.baseurl + ApiEndPoints.authendpoints.reset);

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
          passController.clear();
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
