import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_app/controller/connection_checker/connection_manager_controller.dart';
import 'package:mob_app/util/no_internet.dart';
import 'form.dart/phone_verify.dart';

class Verify_phone_screen extends StatefulWidget {
  Verify_phone_screen({super.key});

  @override
  State<Verify_phone_screen> createState() => _Verify_phone_screenState();
}

class _Verify_phone_screenState extends State<Verify_phone_screen> {
   ConnectionManagerController _controller =Get.put(ConnectionManagerController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => _controller.connectionType.value == 1 ||
            _controller.connectionType.value == 2
        ? Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                "Verifing phone",
                textAlign: TextAlign.end,
              ),
            ),
            body: SizedBox(
                width: double.maxFinite,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: const [
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          "Phone Number",
                          style: TextStyle(
                            fontSize: 28,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "You have to be verified before register!",
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        phone_verify_Form(),
                      ],
                    ),
                  ),
                )))
        : NoInternet());
  
  }
}
