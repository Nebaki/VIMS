import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_app/Componets/Custom_Icons.dart';
import 'package:mob_app/controller/auth/auth.dart';
import '../../../constants/constants.dart';
import '../../../controller/phone_verify/phone_verify.dart';
import '../../../helper/keyboard.dart';
import 'otp_checker.dart';

class phone_verify_Form extends StatefulWidget {
  const phone_verify_Form({super.key});

  @override
  State<phone_verify_Form> createState() => _phone_verify_FormState();
}

class _phone_verify_FormState extends State<phone_verify_Form> {
  final formKey = GlobalKey<FormState>();
  String? phone;
  AuthController phonecontroller = Get.put(AuthController());
  PhoneVerifyController phonever = Get.put(PhoneVerifyController());
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.phone,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            maxLength: 10,
            onSaved: (newValue) => phone = newValue,
            validator: (value) {
              if (value!.isEmpty) {
                return kPhoneNumberNullError;
              } else if (value.length < 10) {
                return kShortphoneError;
              } else if (value.length > 15) {
                return kLongphoneError;
              }
              return null;
            },
            controller: phonecontroller.phoneController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              labelText: "Phone",
              hintText: "Enter your phone",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: const CustomSurffixIcon(
                svgIcon: "assets/icons/Phone.svg",
                color: kPrimaryColor,
              ),
            ),
          ),
          const SizedBox(height: 30),
          const SizedBox(
            height: 10,
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
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    KeyboardUtil.hideKeyboard(context);
                    phonever.verifyPhone(phonecontroller.phoneController.text);
                    Future.delayed(Duration(seconds: 3), () {
                      Get.to(() => phone_OtpScreen());
                      phonever.isLoading.value = false;
                    });
                  }
                },
                child: Obx(
                  () => phonever.isLoading.value
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
              )),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
