import 'package:flutter/material.dart';
import 'package:mob_app/constants/constants.dart';


class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  void Function(String?) onSaved;
   CustomTextField(
      {Key? key,
      required this.onSaved,
      required this.controller,
      required this.hintText,
      required this.obscureText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      obscureText: obscureText,
      controller: controller,
      decoration: otpInputDecoration,
      validator: (val) {
        if (val == null || val.isEmpty) {
          return "Enter your $hintText";
        }
        return null;
      },
    );
  }
}
