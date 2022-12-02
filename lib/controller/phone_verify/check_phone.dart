import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_app/constants/constants.dart';
import 'package:mob_app/controller/phone_verify/phone_verify.dart';
import '../../screen/phone_verify/form.dart/otp_checker.dart';
import '../../util/api_endpoints.dart';
import '../otp.dart';
import 'package:http/http.dart' as http;

class CheckPhoneController extends GetxController {
  PhoneVerifyController phonever = Get.put(PhoneVerifyController());
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

  Future<void> check_phone() async {
    try {
      isLoading.value = true;
      Future.delayed(Duration(seconds: 7));
      phoneController.text.startsWith('0')
          ? replacedPhone = phoneController.text.replaceFirst('0', '+251')
          : replacedPhone = phoneController.text;
      print("--------------------");
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
          showSnackBar("User already exist!");
          isLoading.value = false;
        } else {
          ;
        }
      } else {
        print(replacedPhone);
        phonever.verifyPhone(replacedPhone);
        Future.delayed(Duration(seconds: 4), (() {
          Get.to(() => phone_OtpScreen());
          isLoading.value = false;
        }));
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
