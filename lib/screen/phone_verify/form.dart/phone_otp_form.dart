import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_app/Componets/loading_button.dart';
import 'package:mob_app/controller/phone_verify/phone_verify.dart';
import '../../../constants/constants.dart';
import '../../../helper/keyboard.dart';

class Phone_OtpForm extends StatefulWidget {
  const Phone_OtpForm({
    Key? key,
  }) : super(key: key);

  @override
  _Phone_OtpFormState createState() => _Phone_OtpFormState();
}

class _Phone_OtpFormState extends State<Phone_OtpForm> {
  PhoneVerifyController phone_otp = Get.put(PhoneVerifyController());

  bool hide = false;
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
  bool _isloading = false;
  bool isFirst = true;
  final _otp = TextEditingController();
  final _otp1 = TextEditingController();
  final _otp2 = TextEditingController();
  final _otp3 = TextEditingController();
  final _otp4 = TextEditingController();
  final _otp5 = TextEditingController();
  final _otp6 = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      if (authCredential != null) {
        // Get.toNamed("/profile");
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar("Please try again!");
      setState(() {
        _isloading = false;
      });
      print("-----------------");
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
                  autofocus: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  controller: _otp1,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "";
                    }
                  },
                  onChanged: (value) {
                    nextField(value, pin2FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: 40,
                child: TextFormField(
                  focusNode: pin2FocusNode,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  controller: _otp2,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "";
                    }
                    return null;
                  },
                  onChanged: (value) => nextField(value, pin3FocusNode),
                ),
              ),
              SizedBox(
                width: 40,
                child: TextFormField(
                  focusNode: pin3FocusNode,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    return null;
                  },
                ),
              ),
              SizedBox(
                width: 40,
                child: TextFormField(
                  focusNode: pin4FocusNode,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    return null;
                  },
                ),
              ),
              SizedBox(
                width: 40,
                child: TextFormField(
                  focusNode: pin5FocusNode,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    return null;
                  },
                ),
              ),
              SizedBox(
                width: 40,
                child: TextFormField(
                  focusNode: pin6FocusNode,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  controller: _otp6,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    if (value.length == 1) {
                      pin6FocusNode!.unfocus();
                    }
                  },
                ),
              ),
            ],
          ),
          hide
              ? Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                  child: Row(
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
                  ),
                )
              : TextButton(
                  onPressed: () async {
                    setState(() {
                      hide = true;
                    });
                    try {
                      verificationComplete(
                          PhoneAuthCredential credential) async {
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

                      print(
                          phone_otp.replacedPhone + "-----------------------");
                      await _auth.verifyPhoneNumber(
                        timeout: Duration(seconds: 120),
                        phoneNumber: phone_otp.replacedPhone,
                        verificationCompleted: verificationComplete,
                        verificationFailed: (FirebaseAuthException e) {
                          if (e.code == 'invalid-phone-number') {
                            setState(() {
                              _isloading = false;
                            });
                            showSnackBar("invalid phone number");
                          } else if (e.code == 'too-many-requests') {
                            setState(() {
                              hide = false;
                            });
                            showSnackBar("Too many request");
                          }
                          setState(() {
                            hide = false;
                            _isloading = false;
                          });
                        },
                        codeSent: (verificationId, resendingToken) async {},
                        codeAutoRetrievalTimeout: (verificationId) async {},
                      );
                    } catch (e) {
                      setState(() {
                        _isloading = false;
                      });
                      Future.delayed(Duration(seconds: 60), () {
                        setState(() {
                          hide = false;
                        });
                      });
                      showSnackBar("Please try again!");
                    }

                    ;
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Resend OTP Code",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Color.fromARGB(255, 52, 52, 52)),
                      ),
                    ],
                  ),
                ),
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
                        _otp.text = _otp1.text +
                            _otp2.text +
                            _otp3.text +
                            _otp4.text +
                            _otp5.text +
                            _otp6.text;
                      });
                      Future.delayed(Duration(seconds: 3), () {
                        phone_otp.verifyOtp(_otp.text);
                        setState(() {
                          _isloading = false;
                        });
                      });
                    }
                  },
                  child: _isloading ? LoadingButton() : ContinueButton())),
        ],
      ),
    );
  }
}
