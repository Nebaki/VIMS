import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/constants.dart';
import '../../../controller/otp.dart';
import '../../../helper/keyboard.dart';

class OtpForm extends StatefulWidget {
  const OtpForm({
    Key? key,
  }) : super(key: key);

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  OtpController otp = Get.find();
  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();
  }

  void nextField(String value, FocusNode? focusNode) {
    if (value.length == 1) {
      focusNode!.requestFocus();
    }
  }

  final _formKey = GlobalKey<FormState>();
  bool _isloading = false;
  final _otp = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: 15),
          TextField(
            decoration: InputDecoration(label: Text("otp")),
            controller: _otp,
          )
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     SizedBox(
          //       width: 40,
          //       child: TextFormField(
          //         autofocus: true,
          //         obscureText: true,
          //         style: TextStyle(fontSize: 24),
          //         keyboardType: TextInputType.number,
          //         textAlign: TextAlign.center,
          //         decoration: otpInputDecoration,
          //         onChanged: (value) {
          //           nextField(value, pin2FocusNode);
          //         },
          //       ),
          //     ),
          //     SizedBox(
          //       width: 40,
          //       child: TextFormField(
          //         focusNode: pin2FocusNode,
          //         obscureText: true,
          //         style: TextStyle(fontSize: 24),
          //         keyboardType: TextInputType.number,
          //         textAlign: TextAlign.center,
          //         decoration: otpInputDecoration,
          //         onChanged: (value) => nextField(value, pin3FocusNode),
          //       ),
          //     ),
          //     SizedBox(
          //       width: 40,
          //       child: TextFormField(
          //         focusNode: pin3FocusNode,
          //         obscureText: true,
          //         style: TextStyle(fontSize: 24),
          //         keyboardType: TextInputType.number,
          //         textAlign: TextAlign.center,
          //         decoration: otpInputDecoration,
          //         onChanged: (value) => nextField(value, pin4FocusNode),
          //       ),
          //     ),
          //     SizedBox(
          //       width: 40,
          //       child: TextFormField(
          //         focusNode: pin4FocusNode,
          //         obscureText: true,
          //         style: TextStyle(fontSize: 24),
          //         keyboardType: TextInputType.number,
          //         textAlign: TextAlign.center,
          //         decoration: otpInputDecoration,
          //         onChanged: (value) {
          //           if (value.length == 1) {
          //             pin4FocusNode!.unfocus();
          //             // Then you need to check is the code is correct or not
          //           }
          //         },
          //       ),
          //     ),
          //     SizedBox(
          //       width: 40,
          //       child: TextFormField(
          //         focusNode: pin4FocusNode,
          //         obscureText: true,
          //         style: TextStyle(fontSize: 24),
          //         keyboardType: TextInputType.number,
          //         textAlign: TextAlign.center,
          //         decoration: otpInputDecoration,
          //         onChanged: (value) {
          //           if (value.length == 1) {
          //             pin4FocusNode!.unfocus();
          //             // Then you need to check is the code is correct or not
          //           }
          //         },
          //       ),
          //     ),
          //     SizedBox(
          //       width: 40,
          //       child: TextFormField(
          //         focusNode: pin4FocusNode,
          //         obscureText: true,
          //         style: TextStyle(fontSize: 24),
          //         keyboardType: TextInputType.number,
          //         textAlign: TextAlign.center,
          //         decoration: otpInputDecoration,
          //         onChanged: (value) {
          //           if (value.length == 1) {
          //             pin4FocusNode!.unfocus();
          //             // Then you need to check is the code is correct or not
          //           }
          //         },
          //       ),
          //     ),
          //   ],
          // ),
          ,
          SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                backgroundColor: kPrimaryColor,
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  KeyboardUtil.hideKeyboard(context);
                  setState(() {
                    _isloading = true;
                  });
                  otp.verifyOtp(_otp.text);
                  // Get.toNamed("/otp");
                }
              },
              child: _isloading
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Loading"),
                        SizedBox(
                          height: 30,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      "Continue",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
