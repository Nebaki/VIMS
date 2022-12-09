import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_app/constants/constants.dart';
import 'package:mob_app/screen/otp/otp.dart';
import '../../util/api_endpoints.dart';
import 'package:http/http.dart' as http;

import '../otp.dart';

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
          otp.verifyPhone(replacedPhone);
          Get.to(() => OtpScreen());
          isLoading.value = false;
        } else {
          isLoading.value = false;
          showSnackBar(data["message"]);
        }
      } else {
        isLoading.value = false;
        showSnackBar(data["message"]);
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }
}
