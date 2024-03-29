import 'package:flutter/material.dart';
import 'package:mob_app/util/no_internet.dart';
import 'package:provider/provider.dart';
import '../../constants/constants.dart';
import '../../provider/connectivity_provider.dart';
import 'Components/SignUpForm.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
        );
      } else {
        return NoInternet();
      }
    });
  }
}
