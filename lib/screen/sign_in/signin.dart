import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_app/util/no_internet.dart';
import '../../componets/no_account_text.dart';
import '../../controller/connection_checker/connection_manager_controller.dart';
import 'components/form.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
   ConnectionManagerController _controller =Get.put(ConnectionManagerController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => _controller.connectionType.value == 1 ||
            _controller.connectionType.value == 2
        ? Scaffold(
            appBar: AppBar(
                centerTitle: true,
                title: Text(
                  "Sign In",
                )),
            body: SafeArea(
                child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        "VIMS",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "Sign in with your phone and password",
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      SignForm(),
                      const SizedBox(height: 20),
                      const NoAccountText(),
                    ],
                  ),
                ),
              ),
            )))
        : NoInternet());
  }
}
