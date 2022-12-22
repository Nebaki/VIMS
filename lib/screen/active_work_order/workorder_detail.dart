import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Componets/custome_text.dart';

class ActiveWorkOrderDetail extends StatefulWidget {
  const ActiveWorkOrderDetail({super.key});

  @override
  State<ActiveWorkOrderDetail> createState() => _ActiveWorkOrderDetailState();
}

class _ActiveWorkOrderDetailState extends State<ActiveWorkOrderDetail> {
  var ID = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scaffold(
            appBar: AppBar(
              title: Custome_text(text: "Workorder Details"),
              centerTitle: true,
            ),
            body: Center(
              child: Text(ID),
            )));
  }
}
