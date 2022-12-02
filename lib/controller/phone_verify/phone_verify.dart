import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_app/constants/constants.dart';

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
      replacedPhone.obs;
      verificationComplete(PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value) async {
          if (value.user != null) {
          } else {
            showSnackBar("Failed!!" + "verificationCompleted");
          }
        }).catchError((e) {
          print(e.runtimeType);
          showSnackBar("Please try again! later");
        });
      }

      await auth.verifyPhoneNumber(
        phoneNumber: replacedPhone,
        timeout: Duration(seconds: 40),
        verificationCompleted: verificationComplete,
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            isLoading.value = false;
            showSnackBar("invalid phone number");
          } else if (e.code == 'too-many-requests') {
            showSnackBar("Too many request");
          }
          isLoading.value = false;
        },
        codeSent: (String id, [int? forcesend]) {
          this.verificationId = id;
          authstate.value = "otp sent";
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          showSnackBar("timed out");
        },
      );
    } catch (e) {
      showSnackBar("Please try again later!");
      isLoading.value = false;
      print(e.runtimeType);
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
    } on FirebaseAuthException catch (e) {
      showSnackBar(e.message.toString());
      print('Failed with error code: ${e.code}');
      print(e.message);
    }
    //  catch (e) {
    //   showSnackBar("hey there!");
    //   isLoading.value = false;
    //   print(e.runtimeType);
    // }
  }
}
