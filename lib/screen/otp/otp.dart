import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_app/controller/check_user.dart';
import 'package:mob_app/util/constants.dart';
import 'package:mob_app/util/no_internet.dart';
import 'package:provider/provider.dart';

import '../../provider/connectivity_provider.dart';
import 'components/otp_form.dart';

class OtpScreen extends StatefulWidget {
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  void initState() {
    super.initState();
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
  }

  checkuserController checkuser = Get.put(checkuserController());
  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityProvider>(
        builder: (consumerContext, model, child) {
      if (model.isOnline != null) {
        return model.isOnline
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
                          SizedBox(height: 25),
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
            : NoInternet();
      }
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }
}
