import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constants.dart';
import '../util/api_endpoints.dart';

class ChangeProfileController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String? role;
  var isLoading = false.obs;

  Future<void> change_profile({
    required BuildContext context,
  }) async {
    isLoading.value = true;
    Future.delayed(Duration(seconds: 7));

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      var url = Uri.parse(
          ApiEndPoints.baseurl + ApiEndPoints.authendpoints.change_profile);

      Map body = {
        "email": emailController.text,
        "name": fullNameController.text,
      };

      var res = await http.post(url,
          body: body,
          headers: {HttpHeaders.authorizationHeader: 'Bearer' + token});
      print(res.body);

      if (res.statusCode == 200) {
        print("test");
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var data = jsonDecode(res.body.toString());
        await prefs.setString('name', data['data']['name']);
        await prefs.setString('email', data['data']['email']);
        Get.offNamed("/profile");
        showSnackBar("profile is changed Successfully");
      } else if (res.statusCode == 401) {
        var url_ = Uri.parse(
            ApiEndPoints.baseurl + ApiEndPoints.authendpoints.refreshToken);
        var res_ = await http.post(url_,
            headers: {HttpHeaders.authorizationHeader: "Bearer" + token});
        var data = json.decode(res_.body)["data"];
        if (res_.statusCode == 200) {
          token = data["access_token"];
          var url = Uri.parse(
              ApiEndPoints.baseurl + ApiEndPoints.authendpoints.change_profile);

          Map body = {
            "email": emailController.text,
            "name": fullNameController.text,
          };

          var response = await http.post(url,
              body: body,
              headers: {HttpHeaders.authorizationHeader: 'Bearer' + token});
          if (response.statusCode == 200) {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            var data = jsonDecode(res.body.toString());
            await prefs.setString('name', data['data']['name']);
            await prefs.setString('email', data['data']['email']);
            Get.offNamed("/profile");
            showSnackBar("profile is changed Successfully");
          }
        }
      } else {
        Get.offNamed("/signin");
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }
}
