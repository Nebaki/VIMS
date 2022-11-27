import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../screen/otp/otp.dart';
import '../util/api_endpoints.dart';
import 'package:http/http.dart' as http;

import 'otp.dart';

class checkuserController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  RxString controllerText = ''.obs;
  var isLoading = false.obs;
  String replacedPhone = "";
  OtpController otp = Get.put(OtpController());
  @override
  void onInit() {
    super.onInit();
    phoneController.addListener(() {
      controllerText.value = phoneController.text;
    });
  }

  Future<void> check_user() async {
    try {
      isLoading.value = true;
      Future.delayed(Duration(seconds: 7));
      phoneController.text.startsWith('0')
          ? replacedPhone = phoneController.text.replaceFirst('0', '+251')
          : replacedPhone = phoneController.text;
      var url = Uri.parse(
              ApiEndPoints.baseurl + ApiEndPoints.authendpoints.check_user)
          .replace(queryParameters: {
        'phone': replacedPhone,
      });
      var headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
      };
      final response = await http.get(url, headers: headers);
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        if (data["status"] == true) {
          print(replacedPhone);
          otp.verifyPhone(replacedPhone);
        } else {
          isLoading.value = false;
          Get.rawSnackbar(message: data["message"]);
          // throw jsonDecode(response.body)["message"] ?? "unknown error occured";
        }
      } else {
        isLoading.value = false;
        Get.rawSnackbar(message: data["message"]);

        // print(data["message"]);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
