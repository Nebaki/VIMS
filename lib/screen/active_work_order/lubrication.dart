import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_app/componets/custome_text.dart';

class ActiveLubrication extends StatefulWidget {
  const ActiveLubrication({super.key});

  @override
  State<ActiveLubrication> createState() => _ActiveLubricationState();
}

class _ActiveLubricationState extends State<ActiveLubrication> {
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
        ));
  }
}
