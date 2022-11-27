import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_app/constants/error_handling.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/curret_work_order/current_work_order.dart';
import '../../util/api_endpoints.dart';
import 'package:http/http.dart' as http;

class current_work_order_controller extends GetxController {
  my_work_order? current_work_order;
  fetchWorkorder({required BuildContext context}) async {
    print("Test1");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";
    var url =
        Uri.parse(ApiEndPoints.baseurl + ApiEndPoints.authendpoints.workOrder);
    
    var res = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: 'Bearer' + token});

    httpErrorHandle(
        response: res,
        context: context,
        onSucess: () {
          var data = json.decode(res.body);
          print(data);

          current_work_order = my_work_order.fromJson(data);
        });
  }
}
