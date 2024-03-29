import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mob_app/constants/constants.dart';
import 'package:mob_app/controller/verify_user/verify_user.dart';
import '../util/api_endpoints.dart';

class ResetPassController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passController = TextEditingController();
  checkuserController phone = Get.put(checkuserController());

  Future<void> Reset({
    required BuildContext context,
  }) async {
    try {
      var url =
          Uri.parse(ApiEndPoints.baseurl + ApiEndPoints.authendpoints.reset);
      var replacedPhone = '';
      phone.phoneController.text.startsWith('0')
          ? replacedPhone = phone.phoneController.text.replaceFirst('0', '+251')
          : replacedPhone = phone.phoneController.text;

      print("reset pass " + replacedPhone);

      Map body = {
        "phone": replacedPhone,
        "password": passController.text,
      };
      print(body);
      var res = await http.post(
        url,
        body: body,
      );
      if (res.statusCode==200) {
 Get.offAllNamed("/signin");
            showSnackBar("You have successfully changed your password");
        
      }else{var data = jsonDecode(res.body.toString());
        showSnackBar(data["message"]);
      }
      
    } catch (e) {
      print(e.toString());
    }
  }
}
