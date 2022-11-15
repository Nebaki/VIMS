import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_app/screen/otp/otp.dart';
import '../util/api_endpoints.dart';
import 'package:http/http.dart' as http;

class checkuserController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  RxString controllerText = ''.obs;
  @override
  void onInit() {
    super.onInit();
    phoneController.addListener(() {
      controllerText.value = phoneController.text;
    });
  }

  Future<void> check_user() async {
    try {
      var url = Uri.parse(
              ApiEndPoints.baseurl + ApiEndPoints.authendpoints.check_user)
          .replace(queryParameters: {
        'phone': phoneController.text,
      });
      var headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
      };
      final response = await http.get(url, headers: headers);
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        if (data["status"] == true) {
          Get.rawSnackbar(message:data["message"] ,duration: Duration(seconds: 2));
          Get.toNamed("/forgot_pass");
        } else {
          Get.rawSnackbar(message:data["message"] );
          // throw jsonDecode(response.body)["message"] ?? "unknown error occured";
        }
      } else {
        Get.rawSnackbar(message:data["message"] );
        
        // print(data["message"]);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
