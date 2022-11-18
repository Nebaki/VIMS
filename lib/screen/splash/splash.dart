import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mob_app/controller/user_detail.dart';
import 'package:mob_app/models/api_response.dart';
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

  String? finalToken;
  Future setValue() async {
    final prefs = await SharedPreferences.getInstance();
    final showHome = prefs.getBool('showHome') ?? false;
    // String _token = await get_token();
    // try {
    //   if (showHome == true) {
    //     if (_token == '') {
    //       Get.offNamed("/signin");
    //     } else {
    //       ApiResponse res = (await get_token()) as ApiResponse;
    //       if (res.error == null) {
    //         Get.offNamed("/signin");
    //       } else if (res.error == "Unauthorized") {
    //         Get.offNamed("/signin");
    //       } else {
    //         print(res.error);
    //       }
    //     }
    //   } else {
    //     Get.offAllNamed("/onboard");
    //   }
    // } catch (e) {
    //   print(e.toString());
    // }

      try {
        showHome
            ? Get.offAllNamed(finalToken == null ? "/signin" : "/homepage")
            : Get.offAllNamed("/onboard");

        setState(() {
          finalToken = prefs.getString('token');
        });
        print(finalToken);
      } catch (e) {
        print(e);
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,

          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
      ),
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
