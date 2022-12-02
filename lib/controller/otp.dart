import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_app/constants/constants.dart';

class OtpController extends GetxController {
  var authstate = "".obs;
  var isLoading = false.obs;
  var isLoadingotp = false.obs;
  String verificationId = '';
  FirebaseAuth auth = FirebaseAuth.instance;

  late String replacedPhone;

  Future verifyPhone(String phone) async {
    try {
      isLoading.value = true;
      phone.startsWith('0')
          ? replacedPhone = phone.replaceFirst('0', '+251')
          : replacedPhone = phone;
      verificationComplete(PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value) async {
          if (value.user != null) {
            isLoadingotp.value = false;
          } else {
            isLoadingotp.value = false;
            showSnackBar("Failed!!" + "verificationCompleted");
          }
        }).catchError((e) {
          isLoadingotp.value = false;
          showSnackBar("Please try again!");
        });
      }

      await auth.verifyPhoneNumber(
        phoneNumber: replacedPhone,
        timeout: Duration(seconds: 40),
        verificationCompleted: verificationComplete,
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            showSnackBar("The provided phone number is not valid.");
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
      isLoading.value = false;
      showSnackBar("Please try again!");
    }
  }

  verifyOtp(String otp) async {
    try {
      isLoadingotp.value = true;
      var credential = await auth.signInWithCredential(
          PhoneAuthProvider.credential(
              verificationId: this.verificationId, smsCode: otp));

      if (credential.user != null) {
        Get.toNamed("/forgot_pass");
        isLoadingotp.value = false;
      }
    } catch (e) {
      isLoadingotp.value = false;
      showSnackBar("Please try again!");
    }
  }
}
