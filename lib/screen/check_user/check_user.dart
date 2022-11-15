import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_app/util/no_internet.dart';
import 'package:provider/provider.dart';
import '../../Componets/Custom_Icons.dart';
import '../../Componets/Form_err.dart';
import '../../Componets/defaualt_button.dart';
import '../../provider/connectivity_provider.dart';
import 'component/form.dart';

class CheckUser extends StatefulWidget {
  CheckUser({super.key});

  @override
  State<CheckUser> createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {
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
                  centerTitle: true,
                  title: const Text(
                    "Forgot Password",
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
                              "Tell us your phone and relax",
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 20),
                            CheckUserForm(),
                          ],
                        ),
                      ),
                    )),
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
