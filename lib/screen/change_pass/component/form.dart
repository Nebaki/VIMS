import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:mob_app/componets/loading_button.dart';
import 'package:mob_app/Componets/loading_button.dart';
import '../../../constants/constants.dart';
import '../../../controller/auth/auth.dart';
import '../../../helper/keyboard.dart';
import '../../../util/themes.dart';

class change_pass_form extends StatefulWidget {
  const change_pass_form({super.key});

  @override
  State<change_pass_form> createState() => _change_pass_formState();
}

class _change_pass_formState extends State<change_pass_form> {
  final _formKey = GlobalKey<FormState>();
  String? password;
  String? conform_password;
  bool _oldpasswordVisible = false;
  bool _passwordVisible = false;
  bool _RepasswordVisible = false;
  void initState() {
    super.initState();
    _passwordVisible = false;
    _RepasswordVisible = false;
  }

  AuthController change_pass = Get.put(AuthController());

  void changepass() {
    change_pass.changepass(
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 20),
          buildoldPasswordFormField(),
          const SizedBox(height: 20),
          buildPasswordFormField(),
          const SizedBox(height: 20),
          buildConformPassFormField(),
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
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    KeyboardUtil.hideKeyboard(context);
                    change_pass.changepass(context: context);
                  }
                },
                child: Obx(() => change_pass.isLoading.value
                    ? LoadingButton()
                    : ContinueButton())),
          ),
        ],
      ),
    );
  }

  TextFormField buildoldPasswordFormField() {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: !_oldpasswordVisible,
      onSaved: (newValue) => password = newValue,
      validator: (value) {
        if (value!.isEmpty) {
          return kPassNullError;
        } else if (value.length < 4) {
          return kShortPassError;
        } else if (value.length >= 25) {
          return kLongPassError;
        } else if (value.isNotEmpty) {}
        return null;
      },
      maxLength: 25,
      controller: change_pass.old_passwordController,
      decoration: InputDecoration(
        labelText: "Old password",
        hintText: "Enter your old password",
        suffixIcon: IconButton(
          icon: Icon(
            _oldpasswordVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _oldpasswordVisible = !_oldpasswordVisible;
            });
          },
        ),
        border: inputDecorationTheme().border,
        enabledBorder: inputDecorationTheme().enabledBorder,
        focusedBorder: inputDecorationTheme().focusedBorder,
        contentPadding: inputDecorationTheme().contentPadding,
        floatingLabelBehavior: inputDecorationTheme().floatingLabelBehavior,
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: !_passwordVisible,
      controller: change_pass.newpassController,
      onSaved: (newValue) {
        password = newValue!;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return kPassNullError;
        } else if (value.length < 4) {
          return kShortPassError;
        } else if (value.length >= 25) {
          return kLongPassError;
        }

        return null;
      },
      maxLength: 25,
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        suffixIcon: IconButton(
          icon: Icon(
            _passwordVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
        border: inputDecorationTheme().border,
        enabledBorder: inputDecorationTheme().enabledBorder,
        focusedBorder: inputDecorationTheme().focusedBorder,
        contentPadding: inputDecorationTheme().contentPadding,
        floatingLabelBehavior: inputDecorationTheme().floatingLabelBehavior,
      ),
    );
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: !_RepasswordVisible,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLength: 25,
      onSaved: (newValue) => conform_password = newValue,
      onChanged: (value) {
        conform_password = value;
      },
      controller: change_pass.repassController,
      validator: (value) {
        if (change_pass.newpassController.text !=
            change_pass.repassController.text) {
          return kMatchPassError;
        } else if (value!.isEmpty) {
          return kPassNullError;
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "Confirm password",
          hintText: "Re-enter your password",
          suffixIcon: IconButton(
            icon: Icon(
              _RepasswordVisible ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                _RepasswordVisible = !_RepasswordVisible;
              });
            },
          ),
          border: inputDecorationTheme().border,
          enabledBorder: inputDecorationTheme().enabledBorder,
          focusedBorder: inputDecorationTheme().focusedBorder,
          contentPadding: inputDecorationTheme().contentPadding,
          floatingLabelBehavior: inputDecorationTheme().floatingLabelBehavior),
    );
  }
}
