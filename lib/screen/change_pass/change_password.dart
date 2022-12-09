import 'package:flutter/material.dart';
import 'package:mob_app/util/no_internet.dart';
import 'package:provider/provider.dart';

import '../../provider/connectivity_provider.dart';
import 'component/form.dart';

class Change_pass extends StatefulWidget {
  @override
  State<Change_pass> createState() => _Change_passState();
}

class _Change_passState extends State<Change_pass> {
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
            title: Text("change password"),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 30, right: 30, top: 50),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // Test(),
                  change_pass_form(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      } else {
        return NoInternet();
      }
    });
  }
}
