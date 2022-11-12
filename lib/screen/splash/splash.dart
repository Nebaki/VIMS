import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool isLoggedIn = false;
  @override
  void initState() {
    setValue();
    super.initState();
  }

  String? finalEmail;
  Future setValue() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final showHome = prefs.getBool('showHome') ?? false;
      showHome
          ? Future.delayed(
              Duration(seconds: 3),
              () =>
                  Get.offAllNamed(finalEmail == null ? "/signin" : "/homepage"))
          : Future.delayed(
              Duration(seconds: 3), () => Get.offAllNamed("/onboard"));

      var obtainedemail = prefs.getString('email');
      setState(() {
        finalEmail = obtainedemail;
      });
      print(finalEmail);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          child: Image.asset(
            'assets/images/sp1.png',
            height: 265,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
