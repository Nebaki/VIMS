import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/user_detail.dart';
import '../Profile/components/profile_menu.dart';
import '../Profile/components/profile_pic.dart';
import '../work_order/new_page.dart';
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
                          press: () => Get.toNamed("/profile_edit")),
                      ProfileMenu(
                        text: "Detail of work order",
                        icon: "assets/icons/Settings.svg",
                        press: () {
                          Get.off(() => NewsPage());
                        },
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
      )
    );
  }
}
