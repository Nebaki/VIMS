import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_app/util/no_internet.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/connection_checker/connection_manager_controller.dart';

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

   ConnectionManagerController _controller =Get.put(ConnectionManagerController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => _controller.connectionType.value == 1 ||
            _controller.connectionType.value == 2
        ? Scaffold(
            appBar: AppBar(
              elevation: 0,
            ),
            body: Center(
              child: SizedBox(
                child: Image.asset(
                  'assets/images/sp1.png',
                  height: 265,
                  width: 200,
                ),
              ),
            ),
          )
        : NoInternet());
  }
}
