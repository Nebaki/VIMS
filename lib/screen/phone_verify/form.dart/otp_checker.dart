import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_app/controller/verify_user/verify_user.dart';
import 'package:mob_app/screen/phone_verify/form.dart/phone_otp_form.dart';
import 'package:mob_app/util/no_internet.dart';

import '../../../constants/constants.dart';
import '../../../controller/connection_checker/connection_manager_controller.dart';
import '../../../controller/phone_verify/check_phone.dart';

class phone_OtpScreen extends StatefulWidget {
  @override
  State<phone_OtpScreen> createState() => _phone_OtpScreenState();
}

class _phone_OtpScreenState extends State<phone_OtpScreen> {
  final ConnectionManagerController _controller =
      Get.find<ConnectionManagerController>();
  CheckPhoneController checkphone = Get.put(CheckPhoneController());

  @override
  Widget build(BuildContext context) {
    print(checkphone.controllerText + "-----------+++++++++++++++");
    return Obx(() => _controller.connectionType.value == 1 ||
            _controller.connectionType.value == 2
        ? Scaffold(
            appBar: AppBar(
              title: Text("OTP Verification"),
            ),
            body: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Verify",
                            style: headingStyle,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Obx(
                            () => Text(
                              checkphone.controllerText.value,
                              style: headingStyle,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        "Enter the verification code we sent to you",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 25),
                      FractionallySizedBox(
                        child: Phone_OtpForm(),
                        widthFactor: 1,
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          )
        : NoInternet());
  }
}

Row buildTimer() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text("The code will sent in "),
      TweenAnimationBuilder(
        tween: Tween(begin: 60.0, end: 0.0),
        duration: Duration(seconds: 60),
        builder: (_, dynamic value, child) => Text(
          "00:${value.toInt()}",
          style: TextStyle(color: kPrimaryColor),
        ),
      ),
    ],
  );
}
