import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_app/Componets/Custom_Icons.dart';
import 'package:mob_app/screen/otp/otp.dart';

import '../../../Componets/Form_err.dart';
import '../../../Componets/no_account_text.dart';
import '../../../constants/constants.dart';
import '../../../controller/check_user.dart';
import '../../../controller/otp.dart';
import '../../../helper/keyboard.dart';

class CheckUserForm extends StatefulWidget {
  const CheckUserForm({super.key});

  @override
  State<CheckUserForm> createState() => _CheckUserFormState();
}

class _CheckUserFormState extends State<CheckUserForm> {
  OtpController otp = Get.find();
  final List<String?> errors = [];
  bool _isloading = false;

  final formKey = GlobalKey<FormState>();
  String? phone;
  checkuserController CheckUserController = Get.put(checkuserController());
  final _phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.phone,
            onSaved: (newValue) => phone = newValue,
            validator: (value) {
              if (value!.isEmpty) {
                KeyboardUtil.hideKeyboard(context);
                return kPhoneNumberNullError;
              } else if (value.length < 10) {
                KeyboardUtil.hideKeyboard(context);
                return kShortphoneError;
              } else if (value.length > 15) {
                KeyboardUtil.hideKeyboard(context);
                return kLongphoneError;
              }
              KeyboardUtil.hideKeyboard(context);
              return null;
            },
            controller: _phone,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              labelText: "phone",
              hintText: "Enter your phone",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: const CustomSurffixIcon(
                svgIcon: "assets/icons/Phone.svg",
                color: kPrimaryColor,
              ),
            ),
          ),
          const SizedBox(height: 30),
          FormError(errors: errors),
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
                  setState(() {
                    _isloading = true;
                    CheckUserController.phoneController = _phone;
                  });
                  print("object");
                  otp.verifyPhone(_phone.text);
                  Get.to(() => OtpScreen());
                  // CheckUserController.check_user();
                  print("ob");
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
          const SizedBox(height: 10),
          const NoAccountText(),
        ],
      ),
    );
  }
}
