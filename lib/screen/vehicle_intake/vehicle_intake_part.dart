import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../Componets/row_column_text.dart';
import '../../constants/constants.dart';
import '../../models/vehicleItem/vehicleItem.dart';
import '../../provider/connectivity_provider.dart';
import '../../util/api_endpoints.dart';
import '../sign_in/signin.dart';

class VehicleIntakePart extends StatefulWidget {
  const VehicleIntakePart({super.key});

  @override
  State<VehicleIntakePart> createState() => _VehicleIntakePartState();
}

class _VehicleIntakePartState extends State<VehicleIntakePart> {
  var vehicleItems = <intakeItem>[];
  var isLoading = false;
  var ID = Get.arguments;

  @override
  void initState() {
    print(ID);
    activeWorkorder();
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
    super.initState();
  }

  Future<List<intakeItem>> activeWorkorder() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";

    var url = Uri.parse(
        ApiEndPoints.baseurl + ApiEndPoints.authendpoints.vehiclItem + ID);
    var res = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: 'Bearer' + token});
    if (res.statusCode == 200) {
      print("neba");
      return (json.decode(res.body)['data'] as List)
          .map((e) => intakeItem.fromJson(e))
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
            ApiEndPoints.baseurl + ApiEndPoints.authendpoints.vehiclItem + ID);
        var res = await http.get(url,
            headers: {HttpHeaders.authorizationHeader: 'Bearer' + token});
        if (res.statusCode == 200) {
          return (json.decode(res.body)['data'] as List)
              .map((e) => intakeItem.fromJson(e))
              .toList();
        } else {
          Get.to(() => Signin());
        }
      }
    }
    return (json.decode(res.body)['data'] as List)
        .map((e) => intakeItem.fromJson(e))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Vehicle intake parts"),
      ),
      body: FutureBuilder<List<intakeItem>>(
        future: activeWorkorder(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<intakeItem> active = snapshot.data as List<intakeItem>;

            return ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: active.length,
                itemBuilder: (context, index) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: active[index].vehicleIntakeItems!.length,
                    itemBuilder: (context, index1) {
                      return ListTile(
                        leading: RowText(text: (index1 + 1).toString()),
                        title: RowText(
                            text: active[index]
                                .vehicleIntakeItems![index1]
                                .item
                                .toString()),
                      );
                    },
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
  }
}
