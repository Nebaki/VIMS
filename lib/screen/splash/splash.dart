import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_app/util/no_internet.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../provider/connectivity_provider.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool isLoggedIn = false;
  @override
  void initState() {
    super.initState();
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
    startTimer();
  }

  void startTimer() {
    Timer(Duration(seconds: 4), () {
      setValue(); //It will redirect  after 3 seconds
    });
  }

  String? finalToken;
  Future setValue() async {
    final prefs = await SharedPreferences.getInstance();
    // final showHome = prefs.getBool('showHome') ?? false;

    try {
      setState(() {
        finalToken = prefs.getString('token');
      });
      finalToken == null
          ? Get.offAllNamed("/signin")
          : Get.offAllNamed("/work_order_history");
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Center(
        child: SizedBox(
          child: Image.asset(
            'assets/images/logo.png',
            height: 265,
            width: 200,
          ),
        ),
      ),
    );
  }
}
