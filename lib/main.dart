import 'package:flutter/material.dart';
import 'package:mob_app/screen/Forgot_pass/ForgotPass.dart';
import 'package:mob_app/screen/Home/hompage.dart';
import 'package:mob_app/screen/Sign%20in/Signin.dart';
import 'package:mob_app/screen/Sign%20up/Signup.dart';
import 'package:mob_app/util/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme(),
      routes: {
        '/':(context) => Signin(),
        "/signup":(context) => SignUp(),
        "/homepage":(context) => Homepage(),
        "/forgot_pass":(context) => ForgotPass()
      },
    );
  }
}
