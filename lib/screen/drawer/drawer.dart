import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_app/screen/profile/profile_view.dart';
import 'package:mob_app/screen/test.dart';

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
            text: "Current progress of work order",
            icon: "assets/icons/Settings.svg",
            press: () => Get.offAndToNamed("/currentWorkOrder"),
          ),
          ProfileMenu(
            text: "Work order history",
            icon: "assets/icons/Settings.svg",
            press: () => Get.offAndToNamed("/work_order_history"),
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
