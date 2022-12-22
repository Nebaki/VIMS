import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_app/Componets/row_column_text.dart';
import 'package:mob_app/screen/work_order_history/lubrication.dart';
import 'package:mob_app/screen/work_order_history/workdetail.dart';
import 'package:mob_app/util/no_internet.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Componets/circular_tap.dart';
import '../../Componets/custome_text.dart';
import '../../constants/constants.dart';
import 'package:http/http.dart' as http;
import '../../models/work_order_history/work_order_history.dart';
import '../../provider/connectivity_provider.dart';
import '../../util/api_endpoints.dart';
import '../sign_in/signin.dart';

class work_order_history_screen extends StatefulWidget {
  work_order_history_screen({super.key});

  @override
  State<work_order_history_screen> createState() =>
      _work_order_history_screenState();
}

class _work_order_history_screenState extends State<work_order_history_screen> {
  var workorder = <WorkOrderHistoryModel>[];
  var isLoading = false;
  var ID = Get.arguments;
  @override
  void initState() {
    WorkorderHistory();
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
    super.initState();
  }

  Future<List<WorkOrderHistoryModel>> WorkorderHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";

    var url = Uri.parse(ApiEndPoints.baseurl +
        ApiEndPoints.authendpoints.workOrderHistory +
        ID);
    var res = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: 'Bearer' + token});
    if (res.statusCode == 200) {
      print("neba");
      return (json.decode(res.body)['data'] as List)
          .map((e) => WorkOrderHistoryModel.fromJson(e))
          .toList();
    } else if (res.statusCode == 401) {
      var url_ = Uri.parse(
          ApiEndPoints.baseurl + ApiEndPoints.authendpoints.refreshToken);
      var res_ = await http.post(url_,
          headers: {HttpHeaders.authorizationHeader: "Bearer" + token});
      var data = json.decode(res_.body)["data"];
      if (res_.statusCode == 200) {
        token = data["access_token"];
        var url = Uri.parse(ApiEndPoints.baseurl +
            ApiEndPoints.authendpoints.workOrderHistory +
            ID);
        var res = await http.get(url,
            headers: {HttpHeaders.authorizationHeader: 'Bearer' + token});
        if (res.statusCode == 200) {
          return (json.decode(res.body)['data'] as List)
              .map((e) => WorkOrderHistoryModel.fromJson(e))
              .toList();
        } else {
          Get.to(() => Signin());
        }
      }
    }
    return (json.decode(res.body)['data'] as List)
        .map((e) => WorkOrderHistoryModel.fromJson(e))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityProvider>(
        builder: (consumerContext, model, child) {
      if (model.isOnline != null) {
        return DefaultTabController(
            length: 3,
            child: isLoading
                ? Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Scaffold(
                    appBar: AppBar(
                      title: Custome_text(
                        text: "Work Order History",
                      ),
                      centerTitle: true,
                    ),
                    body: FutureBuilder<List<WorkOrderHistoryModel>>(
                      future: WorkorderHistory(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<WorkOrderHistoryModel> history =
                              snapshot.data as List<WorkOrderHistoryModel>;

                          return ListView.builder(
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemCount: history.length,
                              itemBuilder: (context, index) {
                                return ExpansionTile(
                                  leading:
                                      RowText(text: (index + 1).toString()),
                                  title: Row(
                                    children: [
                                      ColumnText(
                                          text: history[index]
                                              .totalLubricationCost
                                              .toString()),
                                      ColumnText(
                                          text:
                                              history[index].status.toString())
                                    ],
                                  ),
                                  children: [
                                    Container(
                                      height: 100,
                                      child: ListView.builder(
                                          itemCount: 2,
                                          itemBuilder: (context, index1) {
                                            return Column(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Get.to(
                                                      () =>
                                                          HistoryLubrication(),
                                                      arguments: history[index]
                                                          .id
                                                          .toString(),
                                                      transition:
                                                          Transition.native,
                                                      fullscreenDialog: true,
                                                    );
                                                  },
                                                  child: ListTile(
                                                    trailing:
                                                        Icon(Icons.forward),
                                                    title: RowText(
                                                        text: "Lubrications"),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    Get.to(
                                                      () =>
                                                          HistoryWorkOrderDetail(),
                                                      arguments: history[index]
                                                          .id
                                                          .toString(),
                                                      transition:
                                                          Transition.native,
                                                      fullscreenDialog: true,
                                                    );
                                                  },
                                                  child: ListTile(
                                                    trailing:
                                                        Icon(Icons.forward),
                                                    title: RowText(
                                                        text:
                                                            "Workorder Details"),
                                                  ),
                                                )
                                              ],
                                            );
                                          }),
                                    )
                                  ],
                                );
                              });
                        }
                        if (snapshot.hasError) {
                          print(snapshot.error.toString());
                          return Text('error');
                        }
                        return Center(
                            child: CircularProgressIndicator(
                          color: kPrimaryColor,
                        ));
                      },
                    ),
                  ));
      } else {
        return NoInternet();
      }
    });
  }
}
