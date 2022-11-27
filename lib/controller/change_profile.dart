import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constants.dart';
import '../constants/error_handling.dart';
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
        "phone": phoneController.text,
      };
      print(body);
      var res = await http.post(url,
          body: body,
          headers: {HttpHeaders.authorizationHeader: 'Bearer' + token});
      httpErrorHandle(
          response: res,
          context: context,
          onSucess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            var data = jsonDecode(res.body.toString());
            await prefs.setString('name', data['data']['name']);
            await prefs.setString('email', data['data']['email']);
            await prefs.setString('phone', data['data']['phone']);
            Get.offNamed("/profile");
            showSnackBar(context, "profile is changed Successfully");
          });
      isLoading.value = false;
    } catch (e) {
      print(e.toString());
    }
  }
}
