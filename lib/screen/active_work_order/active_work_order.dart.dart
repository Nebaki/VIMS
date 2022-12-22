import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_app/screen/active_work_order/lubrication.dart';
import 'package:mob_app/screen/active_work_order/workorder_detail.dart';
import 'package:mob_app/screen/sign_in/signin.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../Componets/circular_tap.dart';
import '../../Componets/custome_text.dart';
import '../../Componets/row_column_text.dart';
import '../../constants/constants.dart';
import '../../models/work_order_for_vehicle/work_order_for_vehicle.dart';
import '../../provider/connectivity_provider.dart';
import '../../util/api_endpoints.dart';
import '../../util/no_internet.dart';

class current_work_order extends StatefulWidget {
  current_work_order({super.key});

  @override
  State<current_work_order> createState() => _current_work_orderState();
}

class _current_work_orderState extends State<current_work_order> {
  var activeworkorder = <CurrentWorkOrderDetails>[];
  var isLoading = false;
  var ID = Get.arguments;

  @override
  void initState() {
    activeWorkorder();
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
    super.initState();
  }

  Future<List<CurrentWorkOrderDetails>> activeWorkorder() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";

    var url = Uri.parse(
        ApiEndPoints.baseurl + ApiEndPoints.authendpoints.workOrder + ID);
    var res = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: 'Bearer' + token});
    if (res.statusCode == 200) {
      print("neba");
      return (json.decode(res.body)['data'] as List)
          .map((e) => CurrentWorkOrderDetails.fromJson(e))
          .toList();
    } else if (res.statusCode == 401) {
      var url_ = Uri.parse(
          ApiEndPoints.baseurl + ApiEndPoints.authendpoints.refreshToken);
      var res_ = await http.post(url_,
          headers: {HttpHeaders.authorizationHeader: "Bearer" + token});
      var data = json.decode(res_.body)["data"];
      if (res_.statusCode == 200) {
        token = data["access_token"];
        var url = Uri.parse(
            ApiEndPoints.baseurl + ApiEndPoints.authendpoints.workOrder + ID);
        var res = await http.get(url,
            headers: {HttpHeaders.authorizationHeader: 'Bearer' + token});
        if (res.statusCode == 200) {
          return (json.decode(res.body)['data'] as List)
              .map((e) => CurrentWorkOrderDetails.fromJson(e))
              .toList();
        } else {
          Get.to(() => Signin());
        }
      }
    }
    return (json.decode(res.body)['data'] as List)
        .map((e) => CurrentWorkOrderDetails.fromJson(e))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityProvider>(
        builder: (consumerContext, model, child) {
      if (model.isOnline != null) {
        return isLoading
            ? Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Scaffold(
                appBar: AppBar(
                  title: Custome_text(
                    text: "Active work order ",
                  ),
                  centerTitle: true,
                ),
                body: FutureBuilder<List<CurrentWorkOrderDetails>>(
                  future: activeWorkorder(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<CurrentWorkOrderDetails> active =
                          snapshot.data as List<CurrentWorkOrderDetails>;

                      return ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: active.length,
                          itemBuilder: (context, index) {
                            return ExpansionTile(
                              leading: Text((index + 1).toString()),
                              title: Row(
                                children: [
                                  ColumnText(
                                      text: active[index]
                                          .totalLubricationCost
                                          .toString()),
                                  ColumnText(
                                      text: active[index].status.toString())
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
                                                  () => ActiveLubrication(),
                                                  arguments: active[index]
                                                      .id
                                                      .toString(),
                                                  transition: Transition.native,
                                                  fullscreenDialog: true,
                                                );
                                              },
                                              child: ListTile(
                                                trailing: Icon(Icons.forward),
                                                title: Text("Lubrications"),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Get.to(
                                                  () => ActiveWorkOrderDetail(),
                                                  arguments: active[index]
                                                      .id
                                                      .toString(),
                                                  transition: Transition.native,
                                                  fullscreenDialog: true,
                                                );
                                              },
                                              child: ListTile(
                                                trailing: Icon(Icons.forward),
                                                title:
                                                    Text("Workorder Details"),
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
              );
      } else {
        return NoInternet();
      }
    });
  }
}
