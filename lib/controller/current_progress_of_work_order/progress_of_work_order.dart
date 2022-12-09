import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_app/constants/error_handling.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/work_order_for_vehicle/work_order_for_vehicle.dart';
import '../../util/api_endpoints.dart';
import 'package:http/http.dart' as http;

class current_work_order_controller extends GetxController {
  var isDataLoading = false.obs;
  CurrentWorkOrderDetails? current_work_order;
  fetchWorkorder({required BuildContext context}) async {
    try {
      isDataLoading(true);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      var url = Uri.parse(
          ApiEndPoints.baseurl + ApiEndPoints.authendpoints.workOrder);

      var res = await http.get(url,
          headers: {HttpHeaders.authorizationHeader: 'Bearer' + token});
      if (res.statusCode == 200) {
        var data = json.decode(res.body);
        print(data);

        current_work_order = CurrentWorkOrderDetails.fromJson(data);
      } else if (res.statusCode == 200) {
        var url_ = Uri.parse(
            ApiEndPoints.baseurl + ApiEndPoints.authendpoints.refreshToken);
        var res_ = await http.post(url_,
            headers: {HttpHeaders.authorizationHeader: "Bearer" + token});
        var data = json.decode(res_.body)["data"];
        if (res_.statusCode == 200) {
          token = data["access_token"];
          var url = Uri.parse(
              ApiEndPoints.baseurl + ApiEndPoints.authendpoints.workOrder);

          var response = await http.get(url,
              headers: {HttpHeaders.authorizationHeader: 'Bearer' + token});
          if (response.statusCode == 200) {
            var data = json.decode(res.body);
            print(data);
            current_work_order = CurrentWorkOrderDetails.fromJson(data);
          }
        }
      } else {
        return null;
      }
    } catch (e) {
      print('Error while getting data is $e');
    } finally {
      isDataLoading.value = false;
    }
  }
}
