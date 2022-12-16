import 'package:flutter/material.dart';

class VehicleIntakePart extends StatefulWidget {
  const VehicleIntakePart({super.key});

  @override
  State<VehicleIntakePart> createState() => _VehicleIntakePartState();
}

class _VehicleIntakePartState extends State<VehicleIntakePart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Vehicle intake parts"),
      ),
    );
  }
}
