import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_app/util/no_internet.dart';
import '../../constants/constants.dart';
import '../../controller/connection_checker/connection_manager_controller.dart';
import 'Components/SignUpForm.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
 ConnectionManagerController _controller =Get.put(ConnectionManagerController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => _controller.connectionType.value == 1 ||
            _controller.connectionType.value == 2
        ? Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                "Sign up",
              ),
            ),
            body: SafeArea(
                child: SizedBox(
              width: double.maxFinite,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text("Create Account", style: headingStyle),
                      const Text(
                        "Fill your details",
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      SignUpForm(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            )),
          )
        : NoInternet());
  }
}
