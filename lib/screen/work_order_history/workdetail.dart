import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../componets/custome_text.dart';

class HistoryWorkOrderDetail extends StatefulWidget {
  const HistoryWorkOrderDetail({super.key});

  @override
  State<HistoryWorkOrderDetail> createState() => _HistoryWorkOrderDetailState();
}

class _HistoryWorkOrderDetailState extends State<HistoryWorkOrderDetail> {
  var ID = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Custome_text(text: "Workorder Details"),
        centerTitle: true,
      ),
      body: Center(
        child: Text(ID),
      ),
    );
  }
}
