import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../constants/constants.dart';
import '../../constants/error_handling.dart';
import '../../util/api_endpoints.dart';
import '../phone_verify/check_phone.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;

  TextEditingController LoginpassController = TextEditingController();
  TextEditingController LoginphoneController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController old_passwordController = TextEditingController();
  TextEditingController newpassController = TextEditingController();
  TextEditingController repassController = TextEditingController();
  TextEditingController VerphoneController = TextEditingController();
  String? role;
  CheckPhoneController checkphone = Get.put(CheckPhoneController());
  late String replacedPhone = '';

  Future<void> signInUser({
    required BuildContext context,
  }) async {
    String? token = await FirebaseMessaging.instance.getToken();
    isLoading.value = true;
    Future.delayed(Duration(seconds: 7));
    LoginphoneController.text.startsWith('0')
        ? replacedPhone = LoginphoneController.text.replaceFirst('0', '+251')
        : replacedPhone = LoginphoneController.text;
    print(replacedPhone);

    try {
      var url =
          Uri.parse(ApiEndPoints.baseurl + ApiEndPoints.authendpoints.login);
      print(url);

      Map body = {
        "phone": replacedPhone,
        "password": LoginpassController.text,
        "fcm_token": token
      };
      print(body);
      var res = await http.post(url,
          body: jsonEncode(body),
          headers: {'Content-Type': 'application/json; charset=UTF-8'});
      httpErrorHandle(
          response: res,
          context: context,
          onSucess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            var data = jsonDecode(res.body.toString());
            await prefs.setString('token', data['data']['access_token']);
            await prefs.setString('name', data['data']['user']['name']);
            await prefs.setString('user_id', data['data']['user']['id']);
            await prefs.setString('email', data['data']['user']['email']);
            await prefs.setString('phone', data['data']['user']['phone']);
            print(replacedPhone);
            Get.offAllNamed("/vehicleListForCurrentWorkorder");
            isLoading.value = false;
          });
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      showSnackBar(e.toString());
    }
  }

  void signUpUser({
    required BuildContext context,
  }) async {
    isLoading.value = true;
    print(checkphone.phoneController.text + "neba");
    checkphone.phoneController.text.startsWith('0')
        ? replacedPhone =
            checkphone.phoneController.text.replaceFirst('0', '+251')
        : replacedPhone = checkphone.phoneController.text;
    try {
      var url =
          Uri.parse(ApiEndPoints.baseurl + ApiEndPoints.authendpoints.register);

      Map body = {
        "email": emailController.text,
        "password": passController.text,
        "name": fullNameController.text,
        "phone": replacedPhone,
      };

      print(body);
      var res = await http.post(url,
          body: jsonEncode(body),
          headers: {'Content-Type': 'application/json; charset=UTF-8'});
      httpErrorHandle(
          response: res,
          context: context,
          onSucess: () {
            showSnackBar("Account Created Successfully");
            Get.offAllNamed("/signin");
          });
      emailController.clear();
      fullNameController.clear();
      passController.clear();
      phoneController.clear();
      repassController.clear();
      isLoading.value = false;
    } catch (e) {
      showSnackBar(e.toString());
    }
  }

  Future<void> changepass({required BuildContext context}) async {
    try {
      isLoading.value = true;
      Future.delayed(Duration(seconds: 7));
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      var url = Uri.parse(
          ApiEndPoints.baseurl + ApiEndPoints.authendpoints.change_password);

      Map body = {
        "old_password": old_passwordController.text,
        "new_password": newpassController.text,
        "confirm_password": repassController.text,
      };
      var res = await http.post(url,
          body: body,
          headers: {HttpHeaders.authorizationHeader: 'Bearer' + token});
      print(res.body);
      if (res.statusCode == 200) {
        Get.offNamed("/profile");
        showSnackBar("Password is changed Successfully");
      } else if (res.statusCode == 401) {
        var url_ = Uri.parse(
            ApiEndPoints.baseurl + ApiEndPoints.authendpoints.refreshToken);
        var res_ = await http.post(url_,
            headers: {HttpHeaders.authorizationHeader: "Bearer" + token});
        var data = json.decode(res_.body)["data"];
        if (res_.statusCode == 200) {}
      }

      isLoading.value = false;
    } catch (e) {
      print(e.toString());
    }
  }

  // Check user if there is in the database

  Future<void> check_user({required BuildContext context}) async {
    try {
      isLoading.value = true;
      print("11111111111111111111111111111111" + VerphoneController.text);
      var url = Uri.parse(
              ApiEndPoints.baseurl + ApiEndPoints.authendpoints.check_user)
          .replace(queryParameters: {
        'phone': VerphoneController.text,
      });
      var headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
      };
      final response = await http.get(url, headers: headers);
      httpErrorHandle(
          response: response,
          context: context,
          onSucess: () {
            Get.offNamed("/otp");
          });
      isLoading.value = false;
    } catch (e) {
      print(e.toString());
    }
  }
}
