import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_app/util/no_internet.dart';
import '../../controller/connection_checker/connection_manager_controller.dart';
import 'form/form.dart';

class change_profile extends StatefulWidget {
  const change_profile({super.key});

  @override
  State<change_profile> createState() => _change_profileState();
}

 ConnectionManagerController _controller =Get.put(ConnectionManagerController());

class _change_profileState extends State<change_profile> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => _controller.connectionType.value == 1 ||
            _controller.connectionType.value == 2
        ? Scaffold(
            appBar: AppBar(
              title: Text("update profile"),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 30, right: 30, top: 50),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    change_profile_form(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          )
        : NoInternet());
  }
}
