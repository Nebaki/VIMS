import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_app/controller/verify_user/verify_user.dart';
import 'package:mob_app/util/no_internet.dart';
import '../../constants/constants.dart';
import '../../controller/connection_checker/connection_manager_controller.dart';
import 'components/otp_form.dart';

class OtpScreen extends StatefulWidget {
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  ConnectionManagerController _controller =
      Get.put(ConnectionManagerController());

  checkuserController checkuser = Get.put(checkuserController());
  @override
  Widget build(BuildContext context) {
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
                              checkuser.controllerText.value,
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
                      SizedBox(height: 20),
                      FractionallySizedBox(
                        child: OtpForm(),
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

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("This code will sent in "),
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
}
