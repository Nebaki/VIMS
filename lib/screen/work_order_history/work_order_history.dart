import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../componets/circular_tap.dart';
import '../../componets/custome_text.dart';
import '../../constants/constants.dart';
import 'package:http/http.dart' as http;
import '../../models/work_order_history/work_order_history.dart';
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
                  indicator: CircleTabIndicator(color: kPrimaryColor, rad: 4),
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
                  text: "work order history",
                ),
                centerTitle: true,
              ),
              body: TabBarView(children: [
                ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: workorder.length,
                    itemBuilder: (context, index) {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: workorder[index].workOrderDetails!.length,
                          itemBuilder: (context, index1) {
                            return Card(
                              elevation: 8.0,
                              margin: new EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 6.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: Color.fromRGBO(64, 75, 96, .9)),
                                child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 10.0),
                                  leading: Container(
                                    padding: EdgeInsets.only(right: 12.0),
                                    decoration: new BoxDecoration(
                                        border: new Border(
                                            right: new BorderSide(
                                                width: 1.0,
                                                color: Colors.white24))),
                                    child: Icon(Icons.work_history_outlined,
                                        color: Colors.white),
                                  ),
                                  title: Row(
                                    children: [
                                      Custome_text(text: "Failur type:"),
                                      Text(
                                        workorder[index]
                                            .workOrderDetails![index]
                                            .partNoDescription
                                            .toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  subtitle: Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 5,
                                        child: Row(
                                          children: [
                                            Custome_text(text: "Status:"),
                                            Text(
                                                workorder[index]
                                                    .workOrderDetails![index]
                                                    .status
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                          flex: 1,
                                          child: Container(
                                            child: LinearProgressIndicator(
                                                backgroundColor: Color.fromRGBO(
                                                    209, 224, 224, 0.2),
                                                value: 1,
                                                valueColor:
                                                    AlwaysStoppedAnimation(
                                                        Colors.green)),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    }),
                ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: workorder.length,
                    itemBuilder: (context, index) {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: workorder[index].lubrications!.length,
                          itemBuilder: (context, index1) {
                            return Card(
                              elevation: 8.0,
                              margin: new EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 6.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: Color.fromRGBO(64, 75, 96, .9)),
                                child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 10.0),
                                  leading: Container(
                                    padding: EdgeInsets.only(right: 12.0),
                                    decoration: new BoxDecoration(
                                        border: new Border(
                                            right: new BorderSide(
                                                width: 1.0,
                                                color: Colors.white24))),
                                    child: Icon(Icons.oil_barrel,
                                        color: Colors.white),
                                  ),
                                  title: Row(
                                    children: [
                                      Custome_text(text: "Oil type:"),
                                      Text(
                                        workorder[index]
                                            .lubrications![index]
                                            .oilType
                                            .toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  subtitle: Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 5,
                                        child: Row(
                                          children: [
                                            Custome_text(text: "Quantities:"),
                                            Text(
                                                workorder[index]
                                                    .lubrications![index]
                                                    .quantity
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    }),

              
                Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Center(
                        child: Column(children: [
                      Row(children: [
                        Text("Total_lubrication_cost",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Expanded(child: Container()),
                        Custome_text(
                          text: totalLubricationCost!,
                        )
                      ]),
                      Row(children: [
                        Text("Total_parts_cost",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Expanded(child: Container()),
                        Custome_text(
                          text: totalPartsCost!,
                        )
                      ]),
                      Row(children: [
                        Text(
                          "Total_labour_cost",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(child: Container()),
                        Custome_text(
                          text: totalLabourCost!,
                        )
                      ]),
                      Row(children: [
                        Text("Status",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Expanded(child: Container()),
                        Custome_text(
                          text: status!,
                        )
                      ])
                    ]))),
              ]),
            ),
    );
  }
}
