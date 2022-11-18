import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  bool _isloading = false;
  void initState() {
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
                    setState(() {
                      _isloading = true;
                    });
                    change_pass.changepass(context: context);
                  }
                },
                child: Obx(
                  () => change_pass.isLoading.value
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
                )),
          ),
        ],
      ),
    );
  }

  TextFormField buildoldPasswordFormField() {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      obscureText: !_oldpasswordVisible,
      onSaved: (newValue) => password = newValue,
      validator: (value) {
        if (value!.isEmpty) {
          KeyboardUtil.hideKeyboard(context);
          return kPassNullError;
        } else if (value.length < 4) {
          KeyboardUtil.hideKeyboard(context);
          return kShortPassError;
        } else if (value.length >= 25) {
          KeyboardUtil.hideKeyboard(context);
          return kLongPassError;
        } else if (value.isNotEmpty) {
          KeyboardUtil.hideKeyboard(context);
        }
        return null;
      },
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
      obscureText: !_passwordVisible,
      onSaved: (newValue) => password = newValue,
      validator: (value) {
        if (value!.isEmpty) {
          KeyboardUtil.hideKeyboard(context);
          return kPassNullError;
        } else if (value.length < 4) {
          KeyboardUtil.hideKeyboard(context);
          return kShortPassError;
        } else if (value.length >= 25) {
          KeyboardUtil.hideKeyboard(context);
          return kLongPassError;
        } else if (value.isNotEmpty) {
          KeyboardUtil.hideKeyboard(context);
        }
        return null;
      },
      controller: change_pass.newpassController,
      decoration: InputDecoration(
        labelText: "New password",
        hintText: "Enter your new password",
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
      onSaved: (newValue) => conform_password = newValue,
      onChanged: (value) {
        conform_password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          KeyboardUtil.hideKeyboard(context);
          return kPassNullError;
        } else if (value.length < 4) {
          KeyboardUtil.hideKeyboard(context);
          return kShortPassError;
        } else if (value.length >= 25) {
          KeyboardUtil.hideKeyboard(context);
          return kLongPassError;
        } else if (value.isNotEmpty) {
          KeyboardUtil.hideKeyboard(context);
        } else if ((password != value)) {
          return kMatchPassError;
        }
        return null;
      },
      controller: change_pass.repassController,
      decoration: InputDecoration(
          labelText: "Confirm Password",
          hintText: "Re-enter your new password",
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
