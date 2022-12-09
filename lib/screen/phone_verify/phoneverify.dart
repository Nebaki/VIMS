import 'package:flutter/material.dart';
import 'package:mob_app/util/no_internet.dart';
import 'package:provider/provider.dart';
import '../../provider/connectivity_provider.dart';
import 'form.dart/phone_verify.dart';

class Verify_phone_screen extends StatefulWidget {
  Verify_phone_screen({super.key});

  @override
  State<Verify_phone_screen> createState() => _Verify_phone_screenState();
}

class _Verify_phone_screenState extends State<Verify_phone_screen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityProvider>(
        builder: (consumerContext, model, child) {
      if (model.isOnline != null) {
        return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                "Verification",
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
                          "We need to verify your phone before registration!",
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        phone_verify_Form(),
                      ],
                    ),
                  ),
                )));
      } else {
        return NoInternet();
      }
    });
  }
}
