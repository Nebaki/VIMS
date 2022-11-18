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

 

 

  
}
