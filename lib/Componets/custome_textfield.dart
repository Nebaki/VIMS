import 'package:flutter/material.dart';
import 'package:mob_app/constants/constants.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  
  final FocusNode focus;
  void Function(String) onChanged;
  CustomTextField(
      {Key? key,
      required this.onChanged,
      required this.controller,
      required this.focus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focus,
      onChanged: onChanged,
      controller: controller,
      decoration: otpInputDecoration,
      style: TextStyle(fontSize: 24),
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      validator: (val) {
        if (val == null || val.isEmpty) {
          
        }
        return null;
      },
    );
  }
}
