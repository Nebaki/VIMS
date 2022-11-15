import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_app/screen/sign_in/Signin.dart';
import 'package:mob_app/util/no_internet.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../provider/connectivity_provider.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatefulWidget {
  @override
  _Body createState() => _Body();
}

class _Body extends State<Body> {
  late Future profile;
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  void initState() {
    super.initState();
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityProvider>(
        builder: (consumerContext, model, child) {
      if (model.isOnline != null) {
        return model.isOnline
            ? SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    const ProfilePic(),
                    const SizedBox(height: 20),
                    ProfileMenu(
                        text: "My Account",
                        icon: "assets/icons/User Icon.svg",
                        press: () => Get.toNamed("/profile_edit")),
                    ProfileMenu(
                      text: "FeedBack",
                      icon: "assets/icons/Bell.svg",
                      press: () {},
                    ),
                    ProfileMenu(
                      text: "About",
                      icon: "assets/icons/Question mark.svg",
                      press: () {},
                    ),
                    ProfileMenu(
                      text: "Log Out",
                      icon: "assets/icons/Log out.svg",
                      press: () async {
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        preferences.remove("email");
                        Get.offAllNamed("/signin");
                      },
                    ),
                  ],
                ),
              )
            : NoInternet();
      }
      return Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
    });
  }
}

// ···

