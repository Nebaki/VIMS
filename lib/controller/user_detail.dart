import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/api_response.dart';
import '../models/user.dart';
import '../util/api_endpoints.dart';

Future get_user_detail() async {
  ApiResponse api_response = ApiResponse();
  try {
    String token = await get_token();
    var url =
        Uri.parse(ApiEndPoints.baseurl + ApiEndPoints.authendpoints.getProfile);
    print("t2");

    var res = await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    var data = jsonDecode(res.body.toString());
    if (res.statusCode == 200) {
      print(res.statusCode);
      api_response.data = User.fromJson(jsonDecode(res.body));
    } else {
      print(res.statusCode);
      // Get.rawSnackbar(message: data["message"], duration: Duration(seconds: 2));
    }
  } catch (e) {
    print(e.toString());
  }
}

Future<String> get_token() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("token") ?? "";
}

Future<int> get_user_id() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt("user_id") ?? 0;
}

Future<bool> log_out() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.remove("token");
}
