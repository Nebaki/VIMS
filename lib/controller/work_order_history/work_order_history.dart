import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_app/constants/error_handling.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/work_order/work_order_history.dart';
import '../../util/api_endpoints.dart';
import 'package:http/http.dart' as http;

class WorkOrderHistoryController extends GetxController {
  work_order_history? woh;
  fetchWorkorderhistory({required BuildContext context}) async {
    print("Test1");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";
    var url = Uri.parse(
        ApiEndPoints.baseurl + ApiEndPoints.authendpoints.workOrderHistory);
    print("Test2");
    var res = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: 'Bearer' + token});

    List<work_order_history> loadedData = [];
    var data = json.decode(res.body) as Map<String, dynamic>;
    data.forEach((key, value) {
      // loadedData.add(
      // //   work_order_history(
      // //     // message: value["message"],
      // //     // data: (value[data] as List<dynamic>).map((item) => WorkOrderDetails(
      // //     //   partNoDescription: item["partNoDescription"]
      // //     // )).toList()
        
      // // )
      // );
    });
    httpErrorHandle(
        response: res,
        context: context,
        onSucess: () {
          print("Test3");
          print(res.body);
          woh = work_order_history.fromJson(data);
          print(woh!.data[0].lubrications![0]);
        });
  }
}
