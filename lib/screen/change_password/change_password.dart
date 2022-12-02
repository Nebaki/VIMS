import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_app/util/no_internet.dart';

import '../../controller/connection_checker/connection_manager_controller.dart';
import 'component/form.dart';

class Change_pass extends StatefulWidget {
  @override
  State<Change_pass> createState() => _Change_passState();
}

class _Change_passState extends State<Change_pass> {
   ConnectionManagerController _controller =Get.put(ConnectionManagerController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => _controller.connectionType.value == 1 ||
            _controller.connectionType.value == 2
        ? Scaffold(
            appBar: AppBar(
              title: Text("change password"),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 30, right: 30, top: 50),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    // Test(),
                    change_pass_form(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          )
        : NoInternet());
  }
}
