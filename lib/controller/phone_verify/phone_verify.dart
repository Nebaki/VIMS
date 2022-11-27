import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhoneVerifyController extends GetxController {
  var authstate = "".obs;
  var isLoading = false.obs;
  String verificationId = '';
  FirebaseAuth auth = FirebaseAuth.instance;
  final phoneField = TextEditingController();

  late String replacedPhone;

  Future verifyPhone(String phone) async {
    try {
      isLoading.value = true;
      phone.startsWith('0')
          ? replacedPhone = phone.replaceFirst('0', '+251')
          : replacedPhone = phone;
      print(replacedPhone + "+++++++++");
      replacedPhone.obs;

      await auth.verifyPhoneNumber(
        phoneNumber: replacedPhone,
        timeout: Duration(seconds: 40),
        verificationCompleted: (PhoneAuthCredential credential) async {},
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
          }
          isLoading.value = false;
        },
        codeSent: (String id, [int? forcesend]) {
          this.verificationId = id;
          authstate.value = "otp sent";
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      print(e.toString());
    }
  }

  verifyOtp(String otp) async {
    try {
      var credential = await auth.signInWithCredential(
          PhoneAuthProvider.credential(
              verificationId: this.verificationId, smsCode: otp));

      if (credential.user != null) {
        isLoading.value = false;
        Get.toNamed("/signup");
      }
      isLoading.value = false;
    } catch (e) {
      print(e.toString());
    }
  }
}
