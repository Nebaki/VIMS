import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../componets/circular_tap.dart';
import '../../componets/custome_text.dart';
import '../../constants/constants.dart';
import 'package:http/http.dart' as http;
import '../../models/work_order_for_vehicle/work_order_for_vehicle.dart';
import '../../util/api_endpoints.dart';

class current_work_order extends StatefulWidget {
  current_work_order({super.key});

  @override
  State<current_work_order> createState() => _current_work_orderState();
}

class _current_work_orderState extends State<current_work_order> {
  var Currentworkorder = <CurrentWorkOrderDetails>[];
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
        Currentworkorder = workordervalue;
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
                  ],
                ),
                title: Custome_text(
                  text: "Active work order ",
                ),
                centerTitle: true,
              ),
              body: TabBarView(children: [
                Container(
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: Currentworkorder.length,
                      itemBuilder: (_, index) {
                        print(Currentworkorder.length);
                        return Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemCount: Currentworkorder[index]
                                  .workOrderDetails!
                                  .length,
                              itemBuilder: (_, index1) {
                                return Card(
                                  elevation: 10,
                                  margin: new EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 6.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color: Color.fromRGBO(64, 75, 96, .9)),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 15.0, vertical: 10.0),
                                      title: Row(
                                        children: [
                                          Custome_text(text: "Failur type:"),
                                          Text(
                                            Currentworkorder[index1]
                                                .workOrderDetails![index1]
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
                                                    Currentworkorder[index1]
                                                        .workOrderDetails![
                                                            index1]
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
                                                    backgroundColor:
                                                        Color.fromRGBO(
                                                            209, 224, 224, 0.2),
                                                    value: 0.3,
                                                    valueColor:
                                                        AlwaysStoppedAnimation(
                                                            Colors.green)),
                                              )),
                                        ],
                                      ),
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
                                    ),
                                  ),
                                );
                              },
                            )
                          ],
                        );
                      }),
                ),
                Container(
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: Currentworkorder.length,
                      itemBuilder: (_, index) {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemCount: Currentworkorder[index]
                                    .lubrications!
                                    .length,
                                itemBuilder: (_, index1) {
                                  return Card(
                                    elevation: 10,
                                    margin: new EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 6.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          color:
                                              Color.fromRGBO(64, 75, 96, .9)),
                                      child: ListTile(
                                        title: Row(
                                          children: [
                                            Custome_text(text: "Oil type:"),
                                            Text(
                                              Currentworkorder[index]
                                                  .lubrications![index1]
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
                                                  Custome_text(
                                                      text: "Quantity:"),
                                                  Text(
                                                      Currentworkorder[index]
                                                          .lubrications![index1]
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
                                },
                              )
                            ],
                          ),
                        );
                      }),
                ),
              ]),
            ),
    );
  }
}
