import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../util/shared_preference.dart';
import '../profile/profile_menu.dart';
import '../profile/profile_pic.dart';

class drawer extends StatelessWidget {
  const drawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          const ProfilePic(),
          const SizedBox(height: 20),
          ProfileMenu(
              text: "My Account",
              icon: "assets/icons/User Icon.svg",
              press: () => Get.toNamed("/profile")),
          ProfileMenu(
            text: "Active work order",
            icon: "assets/icons/receipt.svg",
            press: () => Get.offAndToNamed("/vehicleListForCurrentWorkorder"),
          ),
          ProfileMenu(
            text: "Work order history",
            icon: "assets/icons/Settings.svg",
            press: () => Get.offAndToNamed("/vehicleList"),
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
              log_out();
              Get.offAllNamed("/signin");
            },
          ),
        ],
      ),
    ));
  }
}
