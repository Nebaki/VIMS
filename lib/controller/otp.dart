import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  var authstate = "".obs;
  String verificationId = '';
  FirebaseAuth auth = FirebaseAuth.instance;

  late String replacedPhone;

  Future verifyPhone(String phone) async {
    try {

      phone.startsWith('0')
          ? replacedPhone = phone.replaceFirst('0', '+251')
          : replacedPhone = phone;

      print(replacedPhone);
      await auth.verifyPhoneNumber(
          phoneNumber: replacedPhone,
          timeout: Duration(seconds: 40),
          verificationCompleted: (AuthCredential authcredential) {},
          verificationFailed: (AuthException) {
            Get.snackbar("Error", "problem shen send the code");
          },
          codeSent: (String id, [int? forcesend]) {
            this.verificationId = id;
            authstate.value = "otp sent";
          },
          codeAutoRetrievalTimeout: (id) {
            this.verificationId = id;
          });
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
        Get.rawSnackbar(message: "neba");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
