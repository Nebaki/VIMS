import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_app/controller/connection_checker/connection_manager_controller.dart';
import 'package:mob_app/util/no_internet.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../componets/circular_tap.dart';
import '../../componets/custome_text.dart';
import '../../constants/constants.dart';
import 'package:http/http.dart' as http;
import '../../models/work_order_for_vehicle/work_order_detail.dart';
import '../../models/work_order_for_vehicle/work_order_for_vehicle.dart';
import '../../provider/connectivity_provider.dart';
import '../../util/api_endpoints.dart';
import 'list_of_vehicle/vehicle.dart';

class current_work_order extends StatefulWidget {
  current_work_order({super.key});

  @override
  State<current_work_order> createState() => _current_work_orderState();
}

class _current_work_orderState extends State<current_work_order> {
  var activeworkorder = <CurrentWorkOrderDetails>[];
  var allWODetails = <WorkOrderDetails>[];
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
    var url = Uri.parse(
        ApiEndPoints.baseurl + ApiEndPoints.authendpoints.workOrder + ID);
    print(url);
    print("-----------------");
    var res = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: 'Bearer' + token});
    try {
      if (res.statusCode == 200) {
        var convertedJsonData = json.decode(res.body)["data"];
        var workordervalue = (convertedJsonData as List)
            .map((e) => CurrentWorkOrderDetails.fromJson(e))
            .toList();
        print(convertedJsonData);
        activeworkorder = workordervalue;
        isLoading = false;
        setState(() {
          isLoading = false;
        });
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
    } finally {}
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityProvider>(
        builder: (consumerContext, model, child) {
      if (model.isOnline != null) {
        return DefaultTabController(
          length: 2,
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
                      ],
                    ),
                    title: Custome_text(
                      text: "Active work order ",
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
                                itemCount: activeworkorder.length,
                                itemBuilder: (context, index) {
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      physics: ClampingScrollPhysics(),
                                      itemCount: activeworkorder[index]
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
                                                    text: activeworkorder[index]
                                                        .workOrderDetails![
                                                            index1]
                                                        .partNoDescription
                                                        .toString(),
                                                  ),
                                                  ColumnText(
                                                      text: activeworkorder[
                                                              index]
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
                                  RowText(text: "Quantity")
                                ],
                              ),
                            ),
                            Divider(),
                            ListView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemCount: activeworkorder.length,
                                itemBuilder: (context, index) {
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      physics: ClampingScrollPhysics(),
                                      itemCount: activeworkorder[index]
                                          .lubrications!
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
                                                    text: activeworkorder[index]
                                                        .lubrications![index1]
                                                        .oilType
                                                        .toString(),
                                                  ),
                                                  ColumnText(
                                                      text: activeworkorder[
                                                              index]
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
                  ]),
                ),
        );
      } else {
        return NoInternet();
      }
    });
  }
}

class Cells {
  Cells(this.cells);
  List<DataCell> cells = [];
}
