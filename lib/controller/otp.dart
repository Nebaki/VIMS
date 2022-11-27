import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../screen/otp/otp.dart';

class OtpController extends GetxController {
  var authstate = "".obs;
  var isLoading = false.obs;
  String verificationId = '';
  FirebaseAuth auth = FirebaseAuth.instance;

  late String replacedPhone;

  Future verifyPhone(String phone) async {
    try {
      isLoading.value = true;
      phone.startsWith('0')
          ? replacedPhone = phone.replaceFirst('0', '+251')
          : replacedPhone = phone;

      await auth.verifyPhoneNumber(
        phoneNumber: replacedPhone,
        timeout: Duration(seconds: 40),
        verificationCompleted: (PhoneAuthCredential credential) async {
          print(credential);
          print(replacedPhone + '@@@@@@@@@@@');
          Get.to(() => OtpScreen());
        },
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
        codeAutoRetrievalTimeout: (String verificationId) {
          
        },
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

      // print("@@@@@@@@@@@@@@" + credential.toString());
      if (credential.user != null) {
        Get.toNamed("/forgot_pass");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
