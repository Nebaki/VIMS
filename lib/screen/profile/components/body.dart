import 'dart:convert';

import 'package:flutter/material.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatefulWidget {
  @override
  _Body createState() => _Body();
}

class _Body extends State<Body> {
 
  late Future profile;
  @override
 
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: "assets/icons/User Icon.svg",
            press: () => Navigator.pushNamed(context, "/profile_edit")
          ),
          ProfileMenu(
            text: "FeedBack",
            icon: "assets/icons/Bell.svg",
            press: () {
              
            },
          ),
          // ProfileMenu(
          //   text: "",
          //   icon: "assets/icons/Settings.svg",
          //   press: () {},
          // ),
          ProfileMenu(
            text: "About",
            icon: "assets/icons/Question mark.svg",
            press: () {
              
            },
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false),
            child: ProfileMenu(
              text: "Log Out",
              icon: "assets/icons/Log out.svg",
              
            ),
          ),
        ],
      ),
    );
  }
}

// ···

