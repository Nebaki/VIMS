import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_app/Componets/Custom_Icons.dart';
import 'package:mob_app/componets/loading_button.dart';
import '../../../Componets/no_account_text.dart';
import '../../../constants/constants.dart';
import '../../../controller/verify_user/verify_user.dart';
import '../../../helper/keyboard.dart';

class CheckUserForm extends StatefulWidget {
  const CheckUserForm({super.key});

  @override
  State<CheckUserForm> createState() => _CheckUserFormState();
}

class _CheckUserFormState extends State<CheckUserForm> {
  final formKey = GlobalKey<FormState>();
  String? phone;
  checkuserController CheckUserController = Get.put(checkuserController());

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
            controller: CheckUserController.phoneController,
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
          const SizedBox(height: 20),
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
                    CheckUserController.check_user();
                  }
                },
                child: Obx(
                  () => CheckUserController.isLoading.value
                      ? LoadingButton()
                      : ContinueButton(),
                ),
              )),
          const SizedBox(height: 10),
          const NoAccountText(),
        ],
      ),
    );
  }
}
