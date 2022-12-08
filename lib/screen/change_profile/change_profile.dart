import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_app/util/no_internet.dart';
import 'package:provider/provider.dart';
import '../../controller/connection_checker/connection_manager_controller.dart';
import '../../provider/connectivity_provider.dart';
import 'form/form.dart';

class change_profile extends StatefulWidget {
  const change_profile({super.key});

  @override
  State<change_profile> createState() => _change_profileState();
}

class _change_profileState extends State<change_profile> {
  @override
  @override
  void initState() {
    super.initState();
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
  }

  Widget build(BuildContext context) {
    return Consumer<ConnectivityProvider>(
        builder: (consumerContext, model, child) {
      if (model.isOnline != null) {
        return Scaffold(
          appBar: AppBar(
            title: Text("update profile"),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 30, right: 30, top: 50),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  change_profile_form(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      } else
        return NoInternet();
    });
  }
}
