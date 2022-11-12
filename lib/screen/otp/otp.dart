import 'package:flutter/material.dart';
import 'package:mob_app/util/constants.dart';
import 'package:mob_app/util/no_internet.dart';
import 'package:provider/provider.dart';

import '../../provider/connectivity_provider.dart';
import 'components/otp_form.dart';

class OtpScreen extends StatefulWidget {
  static String routeName = "/otp";

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  void initState() {
    super.initState();
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
  }

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
                        children: [
                          SizedBox(height: 50),
                          Text(
                            "OTP Verification",
                            style: headingStyle,
                          ),
                          Text("We sent your code to +251 932 501 ***"),
                          buildTimer(),
                          OtpForm(),
                          SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {
                              // OTP code resend
                            },
                            child: Text(
                              "Resend OTP Code",
                              style: TextStyle(
                                  decoration: TextDecoration.underline),
                            ),
                          )
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

Row buildTimer() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text("This code will expired in "),
      TweenAnimationBuilder(
        tween: Tween(begin: 30.0, end: 0.0),
        duration: Duration(seconds: 30),
        builder: (_, dynamic value, child) => Text(
          "00:${value.toInt()}",
          style: TextStyle(color: kPrimaryColor),
        ),
      ),
    ],
  );
}
