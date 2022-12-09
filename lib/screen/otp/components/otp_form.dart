import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_app/componets/loading_button.dart';
import '../../../constants/constants.dart';
import '../../../controller/verify_user/verify_user.dart';
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
  OtpController otp = Get.put(OtpController());
  bool hide = false;
  checkuserController phoneController = Get.put(checkuserController());
  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;
  FocusNode? pin5FocusNode;
  FocusNode? pin6FocusNode;

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    pin5FocusNode = FocusNode();
    pin6FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();
    pin5FocusNode!.dispose();
    pin6FocusNode!.dispose();
  }

  void nextField(String value, FocusNode? focusNode) {
    if (value.length == 1) {
      focusNode!.requestFocus();
    }
  }

  final _formKey = GlobalKey<FormState>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  final _otp = TextEditingController();
  final _otp1 = TextEditingController();
  final _otp2 = TextEditingController();
  final _otp3 = TextEditingController();
  final _otp4 = TextEditingController();
  final _otp5 = TextEditingController();
  final _otp6 = TextEditingController();
  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

    } on FirebaseAuthException catch (e) {
      showSnackBar("Please try again!");
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 40,
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  autofocus: true,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  controller: _otp1,
                  onChanged: (value) {
                    nextField(value, pin2FocusNode);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "";
                    }
                  },
                ),
              ),
              SizedBox(
                width: 40,
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  focusNode: pin2FocusNode,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  controller: _otp2,
                  onChanged: (value) => nextField(value, pin3FocusNode),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "";
                    }
                  },
                ),
              ),
              SizedBox(
                width: 40,
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  focusNode: pin3FocusNode,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  controller: _otp3,
                  onChanged: (value) => nextField(value, pin4FocusNode),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "";
                    }
                  },
                ),
              ),
              SizedBox(
                width: 40,
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  focusNode: pin4FocusNode,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  controller: _otp4,
                  onChanged: (value) => nextField(value, pin5FocusNode),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "";
                    }
                  },
                ),
              ),
              SizedBox(
                width: 40,
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  focusNode: pin5FocusNode,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  controller: _otp5,
                  onChanged: (value) => nextField(value, pin6FocusNode),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "";
                    }
                  },
                ),
              ),
              SizedBox(
                width: 40,
                child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    focusNode: pin6FocusNode,
                    style: TextStyle(fontSize: 24),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: otpInputDecoration,
                    controller: _otp6,
                    onChanged: (value) {
                      if (value.length == 1) {
                        pin6FocusNode!.unfocus();
                      }
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "";
                      }
                    }),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () async {
              setState(() {
                hide = true;
              });
              try {
                verificationComplete(PhoneAuthCredential credential) async {
                  await _auth
                      .signInWithCredential(credential)
                      .then((value) async {
                    if (value.user != null) {
                      setState(() {
                        hide = false;
                      });
                    }
                  }).catchError((e) {
                    setState(() {
                      hide = false;
                    });
                    showSnackBar("Please try again!");
                    print(e.runtimeType);
                  });
                }

                late String replacedPhone = '';
                phoneController.phoneController.text.startsWith('0')
                    ? replacedPhone = phoneController.phoneController.text
                        .replaceFirst('0', '+251')
                    : replacedPhone = phoneController.phoneController.text;

                await _auth.verifyPhoneNumber(
                  timeout: Duration(seconds: 120),
                  phoneNumber: replacedPhone,
                  verificationCompleted: verificationComplete,
                  verificationFailed: (varificationFailed) async {
                    otp.isLoading.value = false;
                    setState(() {
                      hide = false;
                    });
                    showSnackBar("Please try again!");
                  },
                  codeSent: (verificationId, resendingToken) async {},
                  codeAutoRetrievalTimeout: (verificationId) async {},
                );
              } catch (e) {
                setState(() {
                  hide = false;
                });
                showSnackBar("Please try again!");
              }
              Future.delayed(Duration(seconds: 60), () {
                setState(() {
                  hide = false;
                });
              });
            },
            child: hide
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Resending...",
                        style: TextStyle(color: kPrimaryColor),
                      ),
                      TweenAnimationBuilder(
                        tween: Tween(begin: 60.0, end: 0.0),
                        duration: Duration(seconds: 60),
                        builder: (_, dynamic value, child) => Text(
                          "00:${value.toInt()}",
                          style: TextStyle(color: kPrimaryColor),
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Resend OTP Code",
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    ],
                  ),
          ),
          SizedBox(height: 20),
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
                      _otp.text = _otp1.text +
                          _otp2.text +
                          _otp3.text +
                          _otp4.text +
                          _otp5.text +
                          _otp6.text;
                    });
                    otp.verifyOtp(_otp.text);
                  }
                },
                child: Obx(
                  () => otp.isLoadingotp.value
                      ? LoadingButton()
                      : ContinueButton(),
                ),
              )),
        ],
      ),
    );
  }
}
