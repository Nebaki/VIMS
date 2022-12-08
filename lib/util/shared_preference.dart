import 'package:shared_preferences/shared_preferences.dart';


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

