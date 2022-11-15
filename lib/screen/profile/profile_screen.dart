import 'package:flutter/material.dart';
import 'package:mob_app/util/no_internet.dart';
import 'package:provider/provider.dart';

import '../../provider/connectivity_provider.dart';
import 'components/body.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = "/profile";

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
                  title: Text("Profile"),
                ),
                body: Body(),
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
