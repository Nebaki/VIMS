import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class UserPreferences {

  
  Future<bool> saveUser(
    User user,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('name', user.name);
    prefs.setString('email', user.email);
    prefs.setString('phone', user.phone);
    prefs.setString('role', user.role);

    return prefs.commit();
  }

  Future<User> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String name = prefs.getString("name") ?? "";
    String email = prefs.getString("email") ?? "";
    String phone = prefs.getString("phone") ?? "";
    String role = prefs.getString("role") ?? "";

    return User(
      name: name,
      email: email,
      phone: phone,
      role: role,
    );
  }

  Future<bool> saveToken(
    Data ddata,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', ddata.accessToken);
    return prefs.commit();
  }

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String Token = prefs.getString("token") ?? "";
    return Token;
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove('userId');
    prefs.remove('name');
    prefs.remove('email');
    prefs.remove('phone');
    prefs.remove('type');
    prefs.remove('token');
  }

  
}
