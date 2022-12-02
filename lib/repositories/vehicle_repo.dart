import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/vehicle/vehicle.dart';
import '../util/api_endpoints.dart';

class VehicleRepository {
  static Future<List<VehicleModel>?> fetchVehicle(
      ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";
    var url =
        Uri.parse(ApiEndPoints.baseurl + ApiEndPoints.authendpoints.vehicle);
    var res = await http
        .get(url, headers: {HttpHeaders.authorizationHeader: 'Bearer' + token});

    if (res.statusCode == 200) {
      var convertedJsonData = json.decode(res.body)["data"];
      return (convertedJsonData as List)
          .map((e) => VehicleModel.fromJson(e))
          .toList();
    } else {
      return null;
    }
  }
}
