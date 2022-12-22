import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../componets/custome_text.dart';

class HistoryLubrication extends StatefulWidget {
  const HistoryLubrication({super.key});

  @override
  State<HistoryLubrication> createState() => _HistoryLubricationState();
}

class _HistoryLubricationState extends State<HistoryLubrication> {
  var ID = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
          title: Custome_text(text: "Lubrications"),
          centerTitle: true,
        ),
      body: Center(
        child: Text(ID),
      ),
    );
  }
}
