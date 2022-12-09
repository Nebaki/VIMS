import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_app/componets/row_column_text.dart';
import 'package:mob_app/util/no_internet.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../componets/circular_tap.dart';
import '../../componets/custome_text.dart';
import '../../constants/constants.dart';
import 'package:http/http.dart' as http;
import '../../models/work_order_history/work_order_history.dart';
import '../../provider/connectivity_provider.dart';
import '../../util/api_endpoints.dart';

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
    fetchWorkorderhistory();
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
    super.initState();
  }

  fetchWorkorderhistory() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";
    var url = Uri.parse(ApiEndPoints.baseurl +
        ApiEndPoints.authendpoints.workOrderHistory +
        ID);

    var res = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: 'Bearer' + token});
    if (res.statusCode == 200) {
      var convertedJsonData = json.decode(res.body)["data"];
      var workordervalue = (convertedJsonData as List)
          .map((e) => WorkOrderHistoryModel.fromJson(e))
          .toList();
      if (workordervalue != null) {
        workorder = workordervalue;
        isLoading = false;
      }

      setState(() {
        isLoading = false;
      });
    } else if (res.statusCode == 401) {
      print("unauthorized");
      var url_ = Uri.parse(
          ApiEndPoints.baseurl + ApiEndPoints.authendpoints.refreshToken);
      var res_ = await http.post(url_,
          headers: {HttpHeaders.authorizationHeader: "Bearer" + token});
      var data = json.decode(res_.body)["data"];
      print("===================");
      print(res_.body);
      print("@@@@@@@@@@@@@@@@" + data["access_token"]);
      if (res_.statusCode == 200) {
        token = data["access_token"];
        var url = Uri.parse(ApiEndPoints.baseurl +
            ApiEndPoints.authendpoints.workOrderHistory +
            ID);

        var response = await http.get(url,
            headers: {HttpHeaders.authorizationHeader: 'Bearer' + token});
        if (response.statusCode == 200) {
          var convertedJsonData = json.decode(res_.body)["data"];
          var workordervalue = (convertedJsonData as List)
              .map((e) => WorkOrderHistoryModel.fromJson(e))
              .toList();
          if (workordervalue != null) {
            workorder = workordervalue;
            isLoading = false;
          }
          setState(() {
            isLoading = false;
          });
        }
      }
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    String? status = '';
    String? totalLabourCost = "";
    String? totalPartsCost = "";
    String? totalLubricationCost = "";
    try {
      totalLubricationCost = workorder[0].totalLubricationCost.toString();
    } catch (e) {
      totalLubricationCost = null;
    }
    try {
      totalLabourCost = workorder[0].totalLabourCost.toString();
    } catch (e) {
      totalLabourCost = null;
    }
    try {
      totalPartsCost = workorder[0].totalPartsCost.toString();
    } catch (e) {
      totalPartsCost = null;
    }
    try {
      status = workorder[0].status.toString();
    } catch (e) {
      status = null;
    }
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
                    bottom: TabBar(
                      labelPadding: const EdgeInsets.only(left: 20, right: 20),
                      labelColor: Colors.black,
                      isScrollable: true,
                      unselectedLabelColor: Colors.grey,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicator:
                          CircleTabIndicator(color: kPrimaryColor, rad: 4),
                      tabs: [
                        Tab(
                          child: Custome_text(
                            text: "Work order",
                            textstyle: TextStyle(fontSize: 16),
                          ),
                        ),
                        Tab(
                          child: Custome_text(text: "Lubrications"),
                        ),
                        Tab(
                          child: Custome_text(text: "Total"),
                        )
                      ],
                    ),
                    title: Custome_text(
                      text: "Work order history",
                    ),
                    centerTitle: true,
                  ),
                  body: TabBarView(children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                        child: Column(
                          children: [
                            IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RowText(text: "Failur type"),
                                  VerticalDivider(
                                    width: 2,
                                  ),
                                  // Expanded(child: Container()),
                                  RowText(text: "Status")
                                ],
                              ),
                            ),
                            Divider(),
                            ListView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemCount: workorder.length,
                                itemBuilder: (context, index) {
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      physics: ClampingScrollPhysics(),
                                      itemCount: workorder[index]
                                          .workOrderDetails!
                                          .length,
                                      itemBuilder: (context, index1) {
                                        return Column(
                                          children: [
                                            IntrinsicHeight(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  ColumnText(
                                                    text: workorder[index]
                                                        .workOrderDetails![
                                                            index1]
                                                        .partNoDescription
                                                        .toString(),
                                                  ),
                                                  ColumnText(
                                                      text: workorder[index]
                                                          .workOrderDetails![
                                                              index1]
                                                          .status
                                                          .toString()),
                                                ],
                                              ),
                                            ),
                                            Divider(),
                                          ],
                                        );
                                      });
                                }),
                          ],
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                        child: Column(
                          children: [
                            IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RowText(text: "Oil type"),
                                  VerticalDivider(
                                    width: 2,
                                  ),
                                  // Expanded(child: Container()),
                                  RowText(text: "Quatity")
                                ],
                              ),
                            ),
                            Divider(),
                            ListView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemCount: workorder.length,
                                itemBuilder: (context, index) {
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      physics: ClampingScrollPhysics(),
                                      itemCount:
                                          workorder[index].lubrications!.length,
                                      itemBuilder: (context, index1) {
                                        return Column(
                                          children: [
                                            IntrinsicHeight(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  ColumnText(
                                                    text: workorder[index]
                                                        .lubrications![index1]
                                                        .oilType
                                                        .toString(),
                                                  ),
                                                  ColumnText(
                                                      text: workorder[index]
                                                          .lubrications![index1]
                                                          .quantity
                                                          .toString()),
                                                ],
                                              ),
                                            ),
                                            Divider(),
                                          ],
                                        );
                                      });
                                }),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Center(
                            child: Column(children: [
                          Row(children: [
                            Text("Total Lubrication Cost",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Expanded(child: Container()),
                            Custome_text(
                              text: totalLubricationCost ?? "",
                            )
                          ]),
                          Row(children: [
                            Text("Total Parts Cost",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Expanded(child: Container()),
                            Custome_text(
                              text: totalPartsCost ?? "",
                            )
                          ]),
                          Row(children: [
                            Text(
                              "Total Labour Cost",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Expanded(child: Container()),
                            Custome_text(
                              text: totalLabourCost ?? "",
                            )
                          ]),
                          Row(children: [
                            Text("Status",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Expanded(child: Container()),
                            Custome_text(
                              text: status ?? "",
                            )
                          ])
                        ]))),
                  ]),
                ),
        );
      } else {
        return NoInternet();
      }
    });
  }
}
