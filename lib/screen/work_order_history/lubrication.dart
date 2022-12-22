import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_app/componets/custome_text.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../Componets/row_column_text.dart';
import '../../constants/constants.dart';
import '../../models/lubrications/lubrications.dart';
import '../../provider/connectivity_provider.dart';
import '../../util/api_endpoints.dart';
import '../sign_in/signin.dart';

class HistoryLubrication extends StatefulWidget {
  const HistoryLubrication({super.key});

  @override
  State<HistoryLubrication> createState() => _ActiveLubricationState();
}

class _ActiveLubricationState extends State<HistoryLubrication> {
  var lubrication = <Lubrications>[];
  var isLoading = false;
  var ID = Get.arguments;

  @override
  void initState() {
    Lubrication();
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
    super.initState();
  }

  Future<List<Lubrications>> Lubrication() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";

    var url = Uri.parse(
        ApiEndPoints.baseurl + ApiEndPoints.authendpoints.lubrication + ID);
    var res = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: 'Bearer' + token});
    if (res.statusCode == 200) {
      print("neba");
      return (json.decode(res.body)['data'] as List)
          .map((e) => Lubrications.fromJson(e))
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
            ApiEndPoints.baseurl + ApiEndPoints.authendpoints.lubrication + ID);
        var res = await http.get(url,
            headers: {HttpHeaders.authorizationHeader: 'Bearer' + token});
        if (res.statusCode == 200) {
          return (json.decode(res.body)['data'] as List)
              .map((e) => Lubrications.fromJson(e))
              .toList();
        } else {
          Get.to(() => Signin());
        }
      }
    }
    return (json.decode(res.body)['data'] as List)
        .map((e) => Lubrications.fromJson(e))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Custome_text(text: "Lubrications"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ColumnText(text: "St.No"),
              ColumnText(text: "Oil type"),
              ColumnText(text: "Quantity")
            ],
          ),
          FutureBuilder<List<Lubrications>>(
            future: Lubrication(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Lubrications> active = snapshot.data as List<Lubrications>;

                return ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: active.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RowText(text: (index + 1).toString()),
                              RowText(text: active[index].oilType.toString()),
                              RowText(text: active[index].quantity.toString())
                            ],
                          ),
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
        ],
      ),
    );
  }
}
