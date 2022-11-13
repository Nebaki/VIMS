import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Componets/Custom_Icons.dart';
import '../../Componets/Form_err.dart';
import '../../Componets/defaualt_button.dart';
import '../../util/constants.dart';
import '../../util/themes.dart';
import '../../Componets/no_account_text.dart';

class ForgotPass extends StatelessWidget {
  const ForgotPass({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Forgot password",
          textAlign: TextAlign.end,
        ),
      ),
      body: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: const [
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Forgot Password",
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Please enter your email and we will send ",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  ForgotPassForm(),
                ],
              ),
            ),
          )),
    );
  }
}

class ForgotPassForm extends StatefulWidget {
  const ForgotPassForm({super.key});

  @override
  State<ForgotPassForm> createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    List<String> errors = [];
    String? email;
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            onSaved: (newValue) => email = newValue,
            onChanged: (value) {
              if (value.isNotEmpty && errors.contains(kEmailNullError)) {
                setState(() {
                  errors.remove(kEmailNullError);
                });
              } else if (emailValidatorRegExp.hasMatch(value) &&
                  errors.contains(kInvalidEmailError)) {
                setState(() {
                  errors.remove(kInvalidEmailError);
                });
              }
              return null;
            },
            validator: (value) {
              if (value!.isEmpty && !errors.contains(kEmailNullError)) {
                setState(() {
                  errors.add(kEmailNullError);
                });
              } else if (!emailValidatorRegExp.hasMatch(value) &&
                  !errors.contains(kInvalidEmailError)) {
                setState(() {
                  errors.add(kInvalidEmailError);
                });
              }
              return null;
            },
            decoration: InputDecoration(
                labelText: "Email",
                hintText: "Enter your email",
                suffixIcon:
                    const CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg",color: kPrimaryColor,),
                border: inputDecorationTheme().border,
                enabledBorder: inputDecorationTheme().enabledBorder,
                focusedBorder: inputDecorationTheme().focusedBorder,
                contentPadding: inputDecorationTheme().contentPadding,
                floatingLabelBehavior:
                    inputDecorationTheme().floatingLabelBehavior),
          ),
          const SizedBox(height: 30),
          FormError(errors: errors),
          const SizedBox(
            height: 10,
          ),
          DefaultButton(
            text: "Continue",
            press: () {
              if (formKey.currentState!.validate()) {
                Get.toNamed("/otp");
              }
            },
          ),
          const SizedBox(height: 10),
          const NoAccountText(),
        ],
      ),
    );
  }
}
