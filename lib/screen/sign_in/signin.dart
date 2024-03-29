import 'package:flutter/material.dart';
import 'package:mob_app/util/no_internet.dart';
import 'package:provider/provider.dart';
import '../../Componets/no_account_text.dart';
import '../../provider/connectivity_provider.dart';
import 'components/form.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
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
            )));
      } else {
        return NoInternet();
      }
    });
  }
}
